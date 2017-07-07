import React from 'react';
const SearchBar = props => {
  return (
    <div className="row search-bar" >
      <input
        type='text'
        placeholder="Search for an Audition"
        value={props.value}
        onChange={props.onChange}
      />
    </div>
  );
}

export default SearchBar;
