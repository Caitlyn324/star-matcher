import React, { Component } from 'react';
import SearchBar from '../components/SearchBar';
import AuditionsList from '../components/AuditionsList';

class AuditionContainer extends Component {
  constructor (props) {
    super(props);
    this.state = {
      searchTerm: '',
      allAudition: [],
      age: 0,
      gender: "",
      ethnicity: "",
      signedIn: true,
      myType: false
    };

    this.compare = this.compare.bind(this);
    this.getData = this.getData.bind(this);
    this.onChange = this.onChange.bind(this);
    this.findAudition = this.findAudition.bind(this);
    this.handleMyType = this.handleMyType.bind(this);
    this.filterByType = this.filterByType.bind(this);
  }

  compare (a, b) {
    const dateA = a.date;
    const dateB = b.date;

    let comparison = 0;
    if (dateA > dateB) {
      comparison = 1;
    } else if (dateA < dateB) {
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
    fetch('/api/v1/actors.json')
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
      .then(body => {
        if (body !== null) {
          debugger;
          AuditionContainer.setState({
            age: body.age,
            ethnicity: body.ethnicity,
            gender: body.gender,
            signedIn: true
          });
        } else {
          debugger;
        }
      })
      .catch(error => console.error(`Error in fetch ${error.message}`));
  }

  componentWillMount () {
    this.getData();
  }

  handleMyType () {
    let currentState = this.state.myType;
    this.setState({ myType: !currentState });
  }

  onChange (event) {
    let newSearchTerm = event.target.value;
    this.setState({ searchTerm: newSearchTerm });
  }

  findAudition (searchTerm, auditions) {
    let allAudition = auditions;
    let foundAuditions = [];
    console.log(searchTerm);
    allAudition.forEach((audition) => {
      var auditionMatch = false;
      if (audition.show.toLowerCase().includes(searchTerm.toLowerCase())) {
        auditionMatch = true;
      }
      if (auditionMatch) {
        foundAuditions.push(audition); }
    });
    return foundAuditions;
  }

  filterByType (age, ethnicity, gender) {
    let allAudition = this.state.allAudition;
    let foundAuditions = [];
    allAudition.forEach((audition) => {
      let match = false;
        audition.roles.forEach((role) => {
          if (!match) {
            debugger;
            if (role.age_min <= age && age <= role.age_max) {
              debugger;
              if (role.ethnicity.toLowerCase() === "all ethnicities" || role.ethnicity.toLowerCase().inlcudes(ethnicity.toLowerCase())) {
                debugger;
                if (role.gender == 'all genders' || role.gender == gender) {
                  debugger;
                  match = true;
                }
              }
            }
            if (match) {
              foundAuditions.push(audition);
            }
          }
        })
    })
    return foundAuditions;
  }

  render () {
    var auditionsToShow = [];
    if (this.state.searchTerm === '') {
      if (this.state.myType) {
        auditionsToShow = this.filterByType(this.state.age, this.state.ethnicity);
      } else {
        auditionsToShow = this.state.allAudition;
      }
    } else {
      if (this.state.myType) {
        auditionsToShow = this.filterByType(this.state.age, this.state.ethnicity, this.state.gender);
        auditionsToShow = this.findAudition(this.state.searchTerm, auditionsToShow);
      } else {
        auditionsToShow = this.findAudition(this.state.searchTerm, this.state.allAudition);
      }
    }

    return (
      <div id="Audition-Container">
          <SearchBar
          onChange={this.onChange}
          handleClear={this.handleClear}
          value={this.state.searchTerm}
          />
        <div className="row">
          <AuditionsList
            myType={this.state.myType}
            handleMyType={this.handleMyType}
            auditions={auditionsToShow}
            signedIn={this.state.signedIn}
          />
        </div>
      </div>
    );
  }
}

export default AuditionContainer;
