import React from "react"
import PropTypes from "prop-types"
import CsvForm from './CsvForm'
class CsvPreview extends React.Component {
  render () {
    return (
      <React.Fragment>
        <CsvForm key='CsvForm' />
      </React.Fragment>
    );
  }
}

CsvPreview.propTypes = {
  greeting: PropTypes.string
};
export default CsvPreview
