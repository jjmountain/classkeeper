import React from "react"
import PropTypes from "prop-types"

class CsvTable extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      studentColumns: []
    }
    this.handleChange = this.handleChange.bind(this);
  }

  componentDidUpdate(prevProps) {
    if (this.props.csv !== prevProps.csv) {
      var stateObject = this.props.csv[0].map(col => ({ col_name: '' }))
      this.setState({
        studentColumns: stateObject
      })
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
    var prevIndex = 'sexy'
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
    // finally look through all the selects and find the one that has the newColumn property but is not column to update and reset it
  }


  handleSubmit(e) {

  }
 
  renderTable() {
    let csvTable
    if (this.state.studentColumns.length) {
      var submitCsv = <button onClick={this.handleSubmit()}></button>
      var tHeader = this.props.csv[0].map((cell, index) => 
      <th>
        <select name={index} id={`column-${index}`} form='csv-form' onChange={this.handleChange} >
          <option value="" selected="selected" >Select or skip:</option>
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
      csvTable = <table ref="main" className='table table-hover' >
      <thead>
        {tHeader}
      </thead>
      <tbody>
        {this.props.csv.map((row, i) => <tr key={i}>{row.map((cell, index) => <td key={index} style={{'whiteSpace': 'nowrap'}}>{cell}</td>)}</tr>)}
      </tbody>
    </table>
    }
    return csvTable
  }

  render () {
    return (
      <div style={{'overflowX': 'auto'}}>
        {this.renderTable()}
      </div>
    );

}
}

export default CsvTable
