import React from "react"
import PropTypes from "prop-types"

class CsvTable extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      full_name: { value: '' },
      full_name_kanji: { value: '' }, 
      full_name_furigana: { value: '' }, 
      given_name: { value: '' }, 
      given_name_kanji: { value: '' }, 
      given_name_katakana: { value: '' }, 
      family_name: { value: '' }, 
      family_name_kanji: { value: '' }, 
      family_name_furigana: { value: '' },
      student_number: { value: '' }, 
      gender: { value: '' }, 
      year_enrolled: { value: '' },
      email: { value: '' }, 
    }
  }

  handleChange(event) {
    console.log(event.target.value)
  }



  handleSubmit(e) {

  }

  renderTable() {
    let csvTable
    if (this.props.csv.length) {
      var submitCsv = <button onClick={this.handleSubmit()}></button>
      var tHeader = this.props.csv[0].map((cell, index) => 
      <th>
        <select name={index} value={this.state.value} form='csv-form' onChange={this.handleChange}>
          <option value="" disabled selected="selected">Select one or skip:</option>
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
