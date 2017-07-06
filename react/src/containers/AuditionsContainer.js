import React, { Component } from 'react';
import SearchBar from '../components/SearchBar';
import AuditionList from '../components/AuditionList';

class AuditionContainer extends Component {
  constructor (props) {
    super(props);
    this.state = {
      searchTerm: '',
      allAudition: []
    };

    this.compare = this.compare.bind(this);
    this.getData = this.getData.bind(this);
    this.onChange = this.onChange.bind(this);
    this.findAudition = this.findAudition.bind(this);
  }

  compare (a, b) {
    const dateA = a.date;
    const dateB = b.date;

    let comparison = 0;
    if (dateA < dateB) {
      comparison = 1;
    } else if (dateA > dateB) {
      comparison = -1;
    }
    return comparison;
  }

  getData () {
    let AuditionContainer = this;
    fetch('/api/v1/auditions.json')
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} ($response.statusText)`;
          let error = new Error(errorMessage);
          throw (error);
        }
      })
      .then(response => response.json())
      .then(body => body.sort(AuditionContainer.compare))
      .then(sortedAudition => {
        AuditionContainer.setState({ allAudition: sortedAudition });
      })
      .catch(error => console.error(`Error in fetch ${error.message}`));
  }

  componentWillMount () {
    this.getData();
  }

  onChange (event) {
    let newSearchTerm = event.target.value;
    this.setState({ searchTerm: newSearchTerm });
  }

  findAudition (searchTerm) {
    let allAudition = this.state.allAudition;
    let foundAudition = [];
    console.log(searchTerm);
    allAudition.forEach((audition) => {
      var auditionMatch = false;
      if (audition.show.toLowerCase().includes(searchTerm.toLowerCase())) {
        auditionMatch = true;
      }
      if (auditionMatch) { foundAudition.push(audition); }
    });
    return foundAudition;
  }

  render () {
    var auditionsToShow = [];
    if (this.state.searchTerm === '') {
      auditionsToShow = this.state.allAudition;
    } else {
      auditionsToShow = this.findAudition(this.state.searchTerm);
    }

    return (
      <div className="large-12 large-centered columns" id="Audition-Container">
        <SearchBar
          onChange={this.onChange}
          handleClear={this.handleClear}
          value={this.state.searchTerm}
        />
        <AuditionList
          auditions={auditionsToShow}
        />
      </div>
    );
  }
}

export default AuditionContainer;
