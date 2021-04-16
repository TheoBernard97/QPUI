<template>
  <div class="container">
    <!-- 
    <div class="logo">
      <img src="./assets/sw-logo.png" alt="SW-logo">
    </div>
    -->
    <div class="login" v-if="!allow_access">
      <p>Password: </p>
      <input type="password" v-model="password" name="password">
      <button v-on:click="CheckPassword">Ok</button>
    </div>
    <div class="app" v-if="allow_access">
      <div class="informations">
        <div class="rounds">
          <p> Série : {{current_round}}/10</p>
          <button v-on:click="NextRound">Next</button>
        </div>
        <div class="question-buttons">
          <button v-on:click="PrevQuestion">Previous</button>
          <button v-on:click="NextQuestion">Next</button>
        </div>
      </div>
      <div class="question">
        <p> {{round[current_round][current_display].question}}</p>
      </div>
      <div class="answers">
        <div class="answer" v-on:click="GetResponse(); Click1();"
          v-bind:class="{waitresult : wait_for_result, 
          green : round[current_round][current_display].answers[1].isCorrect && !wait_for_result,
          red : clicked == 1 &&  !wait_for_result && !round[current_round][current_display].answers[1].isCorrect
          }">
          <p>A. {{round[current_round][current_display].answers[1].answer}}</p>
        </div>
        <div class="answer" v-on:click="GetResponse(); Click2();"
          v-bind:class="{waitresult : wait_for_result, 
          green : round[current_round][current_display].answers[2].isCorrect && !wait_for_result,
          red : clicked == 2 &&  !wait_for_result && !round[current_round][current_display].answers[2].isCorrect
          }">
          <p>B. {{round[current_round][current_display].answers[2].answer}}</p>
        </div>
        <div class="answer" v-on:click="GetResponse(); Click3();"
          v-bind:class="{waitresult : wait_for_result, 
          green : round[current_round][current_display].answers[3].isCorrect && !wait_for_result,
          red : clicked == 3 &&  !wait_for_result && !round[current_round][current_display].answers[3].isCorrect
          }">
          <p>C. {{round[current_round][current_display].answers[3].answer}}</p>
        </div>
        <div class="answer" v-on:click="GetResponse(); Click4();"
          v-bind:class="{waitresult : wait_for_result, 
          green : round[current_round][current_display].answers[4].isCorrect && !wait_for_result,
          red : clicked == 4 &&  !wait_for_result && !round[current_round][current_display].answers[4].isCorrect
          }">
          <p>D. {{round[current_round][current_display].answers[4].answer}}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
import rounds from "./data/data";

export default {

  name: "App",
  mounted() {
    window.addEventListener("keydown", event => {
      if (event.keyCode == 32){
        this.NextQuestion();
      }
      else if (event.keyCode == 13){
        this.CheckPassword();
      }
    });
  },
  data () {
    return {
      password: "",
      allow_access: false,
      current_display: 1,
      current_round: 1,
      wait_for_result: true,
      clicked: null,
      ...rounds
    }
  },
  methods: {
    CheckPassword () {
      if (this.password === "afterparty") {
        this.allow_access = true;
      }
    },
    PrevQuestion : function () {
      if (this.current_display > 1) {
        this.current_display = this.current_display - 1;
        this.wait_for_result = true;
      }
    },
    NextQuestion : function () {
      if (this.current_display < 10 && this.wait_for_result == false) {
        this.current_display = this.current_display + 1;
        this.wait_for_result = true;
      }
    },
    GetResponse : function () {
      this.wait_for_result = false;
    },
    NextRound : function () {
      if (this.current_round < 10) {
        this.current_round = this.current_round + 1;
        this.current_display = 1;
        this.wait_for_result = true;
      }
    },
    Click1 : function () {
      this.clicked = 1;
    },
    Click2 : function () {
      this.clicked = 2;
    },
    Click3 : function () {
      this.clicked = 3;
    },
    Click4 : function () {
      this.clicked = 4;
    },
  }
};
</script>

<style scoped>    

    .logo {
      margin-top: 150px;
      text-align: center;
    }

    img {
      max-width: 500px;
    }

    .app {  
      position: fixed; 
      bottom: 25px;
      width: 80%;
      padding: 0 10% 0;
      font-size: 1.5rem;
    }

    .login {
      margin-top: 425px;
      text-align: center;
    }

    .login p {
      color: #E9A18A;
    }

    .rounds {
      color: #E9A18A;
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      align-items: center;
    }

    .rounds button {
      max-height: 20px;
    }

    .question-buttons {
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      align-items: center;
    }

    .question {
      border: 2px solid #E9A18A;
      text-align: center;
      color: #E9A18A;
      background-color: #31304A;
    }

    .answers {
      display: grid;
      gap: 10px;
      grid-template-columns: 1fr 1fr;
      grid-template-rows: 50px 50px; 
      margin-top: 25px;
    }

    .answer {
      display: flex;
      align-items: center;
      text-align: left;
      border: 2px solid #E9A18A;
      color: #E9A18A;
      background-color: #31304A;
    }

    .waitresult:hover {
      cursor: pointer;
      background-color: #1F203C;
    }

    .answer p {
      margin: auto;
    }

    .green {
      background-color: #5CB85C;
      color: black;
    }

    .red {
      background-color: #D9534F;
      color: black;
    }
</style>
