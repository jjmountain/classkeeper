import React from "react"
import PropTypes from "prop-types"
class CsvForm extends React.Component {
  render () {
    return (
      <form action="">
        <input type="file" />
        <input type="submit" value='Preview CSV' data-disable-with='Preview Csv' className='btn btn-sm btn-outline-secondary' />
      </form>
    );
  }
}

export default CsvForm
