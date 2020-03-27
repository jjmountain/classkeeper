import React from "react"
import PropTypes from "prop-types"

class CsvTable extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      studentColumns: [
        { col_name: 'full_name', col_index: '' },
        { col_name: 'full_name_kanji', col_index: '' }, 
        { col_name: 'full_name_furigana', col_index: '' }, 
        { col_name: 'given_name', col_index: '' }, 
        { col_name: 'given_name_kanji', col_index: '' }, 
        { col_name: 'given_name_katakana', col_index: '' }, 
        { col_name: 'family_name', col_index: '' }, 
        { col_name: 'family_name_kanji', col_index: '' }, 
        { col_name: 'family_name_furigana', col_index: '' },
        { col_name: 'student_number', col_index: '' }, 
        { col_name: 'gender', col_index: '' }, 
        { col_name: 'year_enrolled', col_index: '' },
        { col_name: 'email', col_index: '' }
      ]
    }
    this.handleChange = this.handleChange.bind(this);
    this.findSelectValue = this.findSelectValue.bind(this);

  }


  // when setting a col index for a col name, find if this index is already on another col_name and reset it to empty string
  // when updating a col also update to empty string if the first option is selected

  handleChange(event) {
    let columnIndex = event.target.name
    let columnToUpdate = event.target.value
    this.setState(prevState => ({
      studentColumns: prevState.studentColumns.map(
        obj => obj.col_name == columnToUpdate ? { ...obj, col_index: columnIndex } : obj
      )
    }))
    this.setState(prevState => ({
      studentColumns: prevState.studentColumns.map(
        obj => obj.col_name != columnToUpdate && obj.col_index == columnIndex ? { ...obj, col_index: '' } : obj
      )
    })
    )
    // go through all the options and check that their value reflects that in state - if not change it to reflect state
    let selects = Array.from(document.getElementsByTagName('select'));

    selects.forEach((select, index) => {
      this.state.studentColumns.forEach((obj) => { 
        if(obj.col_index == select.name) { 
          console.log('same value', obj.col_index, select.name, index)
          selects[index].value = obj.col_name
        } else {
          console.log('diff value', obj.col_index, select.name, index)
        }
      })
    })
  }


  handleSubmit(e) {

  }
 
  // return the value associated with this column index based on state
  // check all the objects for a col_index, when found return the col_name
  findSelectValue(e) {
    console.log(e)
  }

  renderTable() {
    let csvTable
    if (this.props.csv.length) {
      var submitCsv = <button onClick={this.handleSubmit()}></button>
      var tHeader = this.props.csv[0].map((cell, index) => 
      <th>
        <select name={index} form='csv-form' onChange={this.handleChange} >
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
