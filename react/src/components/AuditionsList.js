import React, { Component } from 'react';
import Audition from './Audition';
import PaginationButtons from './PaginationButtons';


class AuditionsList extends Component {
  constructor (props) {
    super(props);
    this.state = {
      auditions: [],
      currentPage: 1,
      auditionsPerPage: 4
    };

    this.previousPage = this.previousPage.bind(this);
    this.nextPage = this.nextPage.bind(this);
  }

  componentWillReceiveProps (nextProps) {
    this.setState({ auditions: nextProps.auditions });
  }

  previousPage (event) {
    if (this.state.currentPage !== 1) {
      let newPage = this.state.currentPage - 1;
      this.setState({ currentPage: newPage });
    }
  }

  nextPage (event) {
    if (this.state.currentPage * this.state.auditionsPerPage < this.state.auditions.length) {
      let newPage = this.state.currentPage + 1;
      this.setState({ currentPage: newPage });
    }
  }

  render () {
    let indexOfLastAudition = this.state.currentPage * this.state.auditionsPerPage;
    let rightBoundIndex = this.state.auditions.length;
    let indexOfFirstAudition = indexOfLastAudition - this.state.auditionsPerPage;
    let currentAuditions;

    if (indexOfFirstAudition <= 0) {
      currentAuditions = this.state.auditions.slice(0, 4);
    } else if (indexOfLastAudition > this.state.auditions.length) {
      indexOfLastAudition = (this.state.currentPage - 1) * this.state.auditionsPerPage;
      currentAuditions = this.state.auditions.slice(indexOfLastAudition, rightBoundIndex);
    } else {
      currentAuditions = this.state.auditions.slice(indexOfFirstAudition, indexOfLastAudition);
    }


    let buttons = null;
    if (this.state.auditions.length > this.state.auditionsPerPage) {
      buttons = <PaginationButtons
      previousPage={this.previousPage}
      nextPage={this.nextPage}
      />;
    }

    let myTypeField = <label className='small-6 columns'value="myType" id="myTypeLabel">
      <input type="checkbox"
      id="myTypeCheckbox"
      value="myType"
      checked={this.props.myType}
      onChange={this.props.handleMyType} />Search by Your Type
    </label>

    let newAuditions = currentAuditions.map((audition, index) => {
      var role_string;
      if (audition.roles.length === 1) {
        role_string = audition.roles[0].title
      } else {
        role_string = audition.roles.length.toString() + " Roles Available"
      }

      return (
        <Audition
        key={index}
        id={audition.id}
        show={audition.show}
        role_string={role_string}
        description={audition.description}
        />
      );
    });
    return (
      <div>
        <div className='row' id="search-aug">
          {myTypeField}
          {buttons}
        </div>
        {newAuditions}
      </div>
    );
  }
}

export default AuditionsList;
