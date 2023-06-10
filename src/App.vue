<template>
  <div class="container">
    <div class="login" v-if="!allow_access">
      <p>Password: </p>
      <input type="password" v-model="password" name="password">
      <button v-on:click="CheckPassword">Ok</button>
    </div>
    <div class="app" v-if="allow_access">
      <div class="rounds">
        <p> Série : {{current_round}}/10</p>
        <button v-on:click="NextRound">Next</button>
      </div>
      <div class="question">
        <img src="./assets/arrow.svg" alt="" class="left-arrow" v-on:click="PrevQuestion">
        <p> {{round[current_round][current_display].question}}</p>
        <img src="./assets/arrow.svg" alt="" class="right-arrow" v-on:click="NextQuestion">
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
      if (this.password === "JJrouette") {
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
      color: whitesmoke;
    }

    .rounds {
      color: whitesmoke;
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      align-items: center;
    }

    .question {
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      align-items: center;
      border: 2px solid whitesmoke;
      text-align: center;
      color: whitesmoke;
      background-color: #111111;
    }

    .question img {
      cursor: pointer;
      color: whitesmoke;
      width: 1rem;
      height: 1rem;
      padding: 2rem;
    }

    .left-arrow {
      transform: rotate(180deg);
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
      border: 2px solid whitesmoke;
      color: whitesmoke;
      background-color: #111111;
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
