import React from 'react';
const Audition = props => {
  return (
    <div className="audition-info-box">
        <a href={`/auditions/${props.id}`}>
          <h2>{props.show}</h2>
        </a>
    </div>
  );
}

export default Audition;
