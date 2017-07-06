import React from 'react';
const SearchBar = props => {
  return (
    <div className="search-bar small-12 columns" >
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
