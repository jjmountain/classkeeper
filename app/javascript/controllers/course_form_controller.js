// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

// listen for a change on the target of the school value
// send an ajax request 
// append the results of the request to the faculties select

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "courseSchool", "courseFaculty" ]

  connect() {
    console.log(this.courseSchoolTarget)
  }

  getFaculties() {
    const url = this.courseSchoolTarget.selectedOptions[0].dataset.url
    if (url) {
      fetch(url)
        .then((response) => {
          return response.json();
        })
        .then((data) => {
          console.log(this.courseFacultyTarget);
          while(this.courseFacultyTarget.firstChild) {
            this.courseFacultyTarget.removeChild(this.courseFacultyTarget.firstChild)
          }
          data.map((item) => {
            let newOption = document.createElement('option');
            newOption.textContent = item['name'];
            newOption.value = item['id'];
            this.courseFacultyTarget.appendChild(newOption);
          })
        });
    }
  }
}