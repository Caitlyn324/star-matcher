import React from 'react';
const Audition = props => {
  return (
    <div className="row audition-info-box">
        <a href={`/auditions/${props.id}`}>
          <h2>{props.show}</h2>
        </a>
        <h3>{props.role_string}</h3>
        <p>{props.description}</p>
    </div>
  );
}

export default Audition;
