import React from "react"
import PropTypes from "prop-types"
import CsvTable from './CsvTable'
import { CSVReader } from 'react-papaparse'

class CsvPreview extends React.Component {
  constructor(props, context) {
    super(props, context)
    this.state = {
      file: []
    }
  }

  handleUserInput = (obj) => {
    this.setState(object)
  }

  onDrop = (data) => {
    var resultsArray = data.map(obj => obj['data'])
    this.setState({
      file: resultsArray
    })
  }

  onError = (err, file, inputElem, reason) => {
    console.log(err)
  }
  
  render () {
    return (
      <React.Fragment>
        <CsvTable csv={this.state.file} />
        <CSVReader 
          onDrop={this.onDrop}
          onError={this.onError}
        >
          <span>Drop CSV file here or click to upload.</span>
        </CSVReader>
      </React.Fragment>
    );
  }
}

CsvPreview.propTypes = {
  greeting: PropTypes.string
};
export default CsvPreview
