<template>
  <div class="todolist">
    <h1 class="default-gray big">To-do list</h1>
    <div class="form create-form">
      <button class="button add-todo default-gray big" @click="createTodo()">
        +
      </button>
      <input
        class="input new-title default-gray"
        type="text"
        v-model="newTodo"
      />
    </div>
    <div class="form view-form">
      <div class="active">
        <div class="todo" v-for="todo in todoList" :key="todo._id">
          <input
            class="checkbox todo-achieved"
            type="checkbox"
            v-model="todo.achieved"
            @change="editTodo(todo._id, todo.title, todo.achieved)"
          />
          <input
            class="input todo-title white"
            type="text"
            v-model="todo.title"
            :readonly="!todo.editMode"
            @dblclick="$set(todo, 'editMode', true)"
          />
          <button
            class="button delete-todo white"
            v-if="!todo.editMode"
            @click="deleteTodo(todo._id)"
          >
            x
          </button>
          <button
            class="button save-todo white"
            v-else
            @click="editTodo(todo._id, todo.title, todo.achieved)"
          >
            save
          </button>
        </div>
      </div>
      <div class="achieved">
        <p class="white">Completed!</p>
        <div class="todo" v-for="todo in achievedList" :key="todo._id">
          <input
            class="checkbox todo-achieved"
            type="checkbox"
            v-model="todo.achieved"
            @change="editTodo(todo._id, todo.title, todo.achieved)"
          />
          <input
            class="input todo-title white"
            type="text"
            v-model="todo.title"
            :readonly="!todo.editMode"
            @dblclick="$set(todo, 'editMode', true)"
          />
          <button
            class="button delete-todo white"
            v-if="!todo.editMode"
            @click="deleteTodo(todo._id)"
          >
            x
          </button>
          <button
            class="button save-todo white"
            v-else
            @click="editTodo(todo._id, todo.title, todo.achieved)"
          >
            save
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'

export default Vue.extend({
  name: 'TodoList',
  data() {
    return {
      newTodo: 'Add a task!',
      todoList: [] as {
        _id: string
        title: string
        achieved: boolean
        editMode?: boolean
      }[],
      achievedList: [] as {
        _id: string
        title: string
        achieved: boolean
        editMode?: boolean
      }[],
    }
  },
  props: {},
  methods: {
    createTodo() {
      let postData = {
        title: this.newTodo,
        achieved: false,
      }
      if (postData.title === '') {
        return
      }
      this.$axios.post(`/todolist/todo`, postData).then((data) => {
        console.log(data)
        this.fetchTodos()
      })
    },
    editTodo(id: string, title: string, achieved: boolean) {
      let postData = {
        title: title,
        achieved: achieved,
      }
      this.$axios.put(`/todolist/edit?todoID=${id}`, postData).then((data) => {
        console.log(data)
        this.fetchTodos()
      })
    },
    deleteTodo(id: string) {
      this.$axios.delete(`/todolist/delete?todoID=${id}`).then((data) => {
        console.log(data)
        this.fetchTodos()
      })
    },
    fetchTodos() {
      this.$axios.get(`/todolist/todos`).then((data) => {
        this.todoList = data.data.filter(
          (todo: {
            _id: string
            title: string
            achieved: boolean
            editMode: boolean
          }) => !todo.achieved
        )
        this.achievedList = data.data.filter(
          (todo: {
            _id: string
            title: string
            achieved: boolean
            editMode: boolean
          }) => todo.achieved
        )
      })
    },
  },
  mounted() {
    this.fetchTodos()
  },
})
</script>

<style scoped lang="scss">
.todolist {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;

  .form {
    display: flex;
    overflow: hidden;

    width: 50%;
  }

  button {
    width: 50px;
    border: none;
    background-color: transparent;
  }

  .input {
    width: 100%;
    border: none;
    outline: none;
    background-color: transparent;

    font-size: 20px;
  }

  .checkbox {
    width: 50px;
  }

  .create-form {
    height: 50px;

    border: 1px solid #535568;
    border-radius: 10px;

    margin: 25px 0px;

    &:focus-within {
      background: #383a4c;
      .new-title {
        color: white !important;
      }
    }
  }

  .view-form {
    display: flex;
    flex-direction: column;

    .achieved {
      border-top: 2px solid #383a4c;
      text-align: left;

      margin: 20px 0px;
    }

    .todo {
      display: flex;
      align-items: center;

      width: 100%;
      height: 50px;

      border: 1px solid #383a4c;
      border-radius: 10px;

      background: #383a4c;
      color: white;

      margin: 4px 0px;
    }
  }
}
</style>
