import React, { Component } from 'react';
import SearchBar from '../components/SearchBar';
import AuditionsList from '../components/AuditionsList';

class AuditionContainer extends Component {
  constructor (props) {
    super(props);
    this.state = {
      searchTerm: '',
      allAuditions: [],
      age: 0,
      gender: "",
      ethnicity: "",
      signedIn: false,
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
    fetch('/api/v1/auditions.json', {
      'credentials': 'same-origin'
    })
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
        AuditionContainer.setState({
          allAuditions: body.auditions,
          gender: body.actor.gender,
          age: body.actor.age,
          ethnicity: body.actor.ethnicity,
          signedIn: body.signedIn
        });
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
    let allAuditions = auditions;
    let foundAuditions = [];
    console.log(searchTerm);
    allAuditions.forEach((audition) => {
      var auditionMatch = false;
      if (audition.show.toLowerCase().includes(searchTerm.toLowerCase())) {
        auditionMatch = true;
      }
      if (auditionMatch) {
        foundAuditions.push(audition); }
    });
    return foundAuditions;
  }

  filterByType () {
    let allAuditions = this.state.allAuditions;
    let foundAuditions = [];
    let actor_age = this.state.age;
    let actor_ethnicity = this.state.ethnicity.toLowerCase()
    let actor_gender = this.state.gender.toLowerCase()

    allAuditions.forEach((audition) => {
      let match = false;
        audition.roles.forEach((role) => {
          if (!match) {
            if (role.age_min <= actor_age && actor_age <= role.age_max) {
              let role_ethnicity = role.ethnicity.toLowerCase()
              if (role_ethnicity === '' || role_ethnicity === "all ethnicities" || role_ethnicity.includes(actor_ethnicity)) {
                let role_gender = role.gender.toLowerCase()
                if (role_gender == 'all genders' || role_gender == actor_gender) {
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
        auditionsToShow = this.state.allAuditions;
      }
    } else {
      if (this.state.myType) {
        auditionsToShow = this.filterByType();
        auditionsToShow = this.findAudition(this.state.searchTerm, auditionsToShow);
      } else {
        auditionsToShow = this.findAudition(this.state.searchTerm, this.state.allAuditions);
      }
    }
    let totalSize = auditionsToShow.length;
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
            size={totalSize}
          />
        </div>
      </div>
    );
  }
}

export default AuditionContainer;
