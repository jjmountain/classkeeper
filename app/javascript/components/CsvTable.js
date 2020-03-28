import React from "react"
import PropTypes from "prop-types"
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import "bootstrap/dist/css/bootstrap.min.css";



class CsvTable extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      studentColumns: [],
      showModal: false,
      customEmailField: {
        col_name: '',
        email_domain: ''
      },
      errors: {
        emailFormatIncorrect: '',
        emailsNotUnique: '',
        namesChecked: '',
        passwords: ''
    }
    }
    this.handleChange = this.handleChange.bind(this);
    this.checkForEmail = this.checkForEmail.bind(this);
    this.validateCustomEmail = this.validateCustomEmail.bind(this);
    this.hideModal = this.hideModal.bind(this);
    this.renderExample = this.renderExample.bind(this);
    this.handleEmailTextChange = this.handleEmailTextChange.bind(this);
    this.handleEmailPrefixChange = this.handleEmailPrefixChange.bind(this);

  }

  componentDidUpdate(prevProps) {
    if (this.props.csv !== prevProps.csv) {
      var stateObject = this.props.csv[0].map((col, index) => ({ col_name: '', col_index: index }))
      this.setState({
        studentColumns: stateObject,
        showModal: false,
        customEmailField: {
          col_name: '',
          email_domain: ''
        },
        errors: {
          emailFormatIncorrect: '',
          emailsNotUnique: '',
          namesChecked: '',
          passwords: '',
        }
      })
      document.querySelectorAll("select[id^='column-']").forEach(select => select.value = '')
    }
  }
  
  // set the state to be an array of objects, each of which contain a col_name attribute

  // when setting a col index for a col name, find if this index is already on another col_name and reset it to empty string
  // when updating a col also update to empty string if the first option is selected

  handleChange(event) {
    let columnNumberToUpdate = event.target.name
    let newColumnProperty = event.target.value

    this.setState(prevState => ({
      studentColumns: prevState.studentColumns.map( 
        (obj, index) => {
          return index == columnNumberToUpdate ? { ...obj, col_name: newColumnProperty } : obj 
        }
      )
    }))

    // look through the state and see if a select has the same property and is not the column number to update - if so reset it
    this.setState(prevState => ({
      studentColumns: prevState.studentColumns.map(
        (obj, index) => { 
          if(index != columnNumberToUpdate && obj.col_name == newColumnProperty) {
            document.querySelector(`#column-${index}`).value = ''
          }
          return index != columnNumberToUpdate && obj.col_name == newColumnProperty ? { ...obj, col_name: '' } : obj 
        }
      )
    })
    )
  }


  checkForEmail(e) {
    // check state for email col_name inside each object
    // get an array of the col_names preset
    var colsPresent = this.state.studentColumns.map(col => col.col_name)
    if(colsPresent.some(el => el == 'email')) {
      
    } else {
      this.setState({
        showModal: true
      })
     
    }
  }

  validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}

  validateCustomEmail() {
    if(this.validateEmail(this.renderExample())) {
      this.setState(prevState => ({
        errors: {
          ...prevState.errors,
          emailFormatIncorrect: false
        }
      }))
      this.checkEmailUniqueness()
    } else {
      this.setState(prevState => ({
        errors: {
          ...prevState.errors,
          emailFormatIncorrect: true
        }
      }))
    }
  }

  usingCustomEmail() {
    return this.state.customEmailField.email_domain.length > 0 && this.state.customEmailField.col_name.length > 0
  }

  checkEmailUniqueness() {
    let emailsNotUnique
    function onlyUnique(value, index, self) { 
      return self.indexOf(value) === index;
  }
    if (this.usingCustomEmail()) {
      let prefixObj = this.state.studentColumns.find(obj => obj.col_name == this.state.customEmailField.col_name)
      let emailPrefixArr = this.props.csv.map(arr => arr[prefixObj.col_index])
      let uniqueArr = emailPrefixArr.filter(onlyUnique)
      emailsNotUnique = uniqueArr.length != emailPrefixArr.length
    } else {
      let emailObj = this.state.studentColumns.find(obj => obj.col_name == 'email')
      let emailsArr = this.props.csv.map(arr => arr[emailObj.col_index])
      let uniqueArr = emailsArr.filter(onlyUnique)
      emailsNotUnique = uniqueArr.length != emailsArr.length
    }
    this.setState(prevState => ({
      errors: {
        ...prevState.errors,
        emailsNotUnique: emailsNotUnique
      }
    }))
  }

  handleEmailPrefixChange(e) {
    let valueToUpdate = e.target.value
    this.setState(prevState => ({
      ...prevState, 
      customEmailField: {
        ...prevState.customEmailField,
        col_name: valueToUpdate
      }
    }))
  }

  handleEmailTextChange(e) {
    let valueToUpdate = e.target.value
    this.setState(prevState => ({
      ...prevState,
      customEmailField: {
        ...prevState.customEmailField,
        email_domain: valueToUpdate
      }
    }))
  }

  hideModal(e) {
    this.setState({
      showModal: false
    })
  } 

  renderErrors() {
    if(this.state.showModal) {
      let errorsArr = []
      if(this.state.errors.emailsNotUnique) {
        errorsArr.push('Email addresses must all be unique')
      }
      if(this.state.errors.emailFormatIncorrect) {
        errorsArr.push('An email address in the incorrect format was found')
      } 
      return ( 
        <ul className='alert list-group'>{errorsArr.map(str => <li className='text-red list-group-item'>{str}</li>)}</ul> 
        )}
  } 

  renderExample() {
    if (this.usingCustomEmail()) {
      let completeExample = ''
        this.state.studentColumns.forEach((obj, index) => {
          if (obj.col_name == this.state.customEmailField.col_name) {
            completeExample = this.props.csv[1][index]
          }
        }
      )
      completeExample += this.state.customEmailField.email_domain
      return completeExample
    }
  }
 
  renderTable() {
    let csvTable
    if (this.state.studentColumns.length) {
      var tHeader = this.props.csv[0].map((cell, index) => 
      <th>
        <select name={index} id={`column-${index}`} form='csv-form' onChange={this.handleChange} >
          <option defaultValue="" value=''>Select or skip:</option>
          <option value="full_name">Full Name - English</option>
          <option value="full_name_furigana">Full Name - Furigana</option>
          <option value="full_name_kanji">Full Name - Kanji</option>
          <option value="given_name">Given Name - English</option>
          <option value="given_name_furigana">Given Name - Furigana</option>
          <option value="given_name_kanji">Given Name - Kanji</option>
          <option value="family_name">Family Name - English</option>
          <option value="family_name_furigana">Family Name - Furigana</option>
          <option value="family_name_kanji">Family Name - Kanji</option>
          <option value="student_number">Student Number</option>
          <option value="gender">Gender</option>
          <option value="year_enrolled">Year Enrolled</option>
          <option value="email">Email</option>
        </select>
        </th>)
      csvTable =
      <div>              
        <table ref="main" className='table table-hover' >
        <thead>
          <tr>
            {tHeader}
          </tr>
        </thead>
        <tbody>
          {this.props.csv.map((row, i) => <tr key={i}>{row.map((cell, index) => <td key={index} style={{'whiteSpace': 'nowrap'}}>{cell}</td>)}</tr>)}
        </tbody>
      </table>
      </div>
    }
    return csvTable
  }

  render () {
    var emailFirstFieldOptions = this.state.studentColumns.map(col => col.col_name).filter(col => col != '').map(option => {
      return <option value={option}>{option.replace(/_/g, ' ')}</option>
    })

    var emailCheckModal = 
      <Modal show={this.state.showModal}>
        <Modal.Header>
          <Modal.Title>Confirmation</Modal.Title></Modal.Header>
        <Modal.Body>
          <p><strong>To register or enroll students an email address is required.</strong></p>
          <p>If the first part of the email address is provided in another column (e.g. student number or username) you can complete the email address by entering the remainder of the email from the @ mark in the space below.</p>
          <select name="email_first_field" onChange={this.handleEmailPrefixChange}>
            <option defaultValue="" value=''>Choose below:</option>
            {emailFirstFieldOptions}
          </select>
          <input type="text" onChange={this.handleEmailTextChange} value={this.state.customEmailField.email_domain} className='ml-2'/>
          <p className='mt-2'>Example:</p>
          {this.renderExample()}
          {this.renderErrors()}
        </Modal.Body>
        <Modal.Footer>
          <Button onClick={this.hideModal}>Cancel</Button>
          <Button onClick={this.validateCustomEmail}>Save</Button>
        </Modal.Footer>
      </Modal>

    return (
      <>
      {this.props.csv.length > 0 && <button className='btn btn-info my-3' onClick={this.checkForEmail}>Enroll Students</button>}
      <div style={{'overflowX': 'auto'}}>
        {this.renderTable()}
        {emailCheckModal}
      </div>
      </>
    );

}
}

export default CsvTable
