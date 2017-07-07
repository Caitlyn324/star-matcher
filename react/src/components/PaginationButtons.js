import React from 'react';
const PaginationButtons = props => {
  return (
    <div className="button-group small-6 text-right columns" id="pagination-buttons">
       <button className="button" onClick={props.previousPage}>
         Previous Page
       </button>
       <button className="button" onClick={props.nextPage}>
         Next Page
       </button>
    </div>
  );
}

export default PaginationButtons;
