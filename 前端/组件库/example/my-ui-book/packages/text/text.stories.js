import MyText from './text.vue';

export default {
  title: 'PengLai/Text',
  component: MyText,
  argTypes: {
    color: { control: 'color' }
  },
};

const Template = (args, { argTypes }) => ({
    props: Object.keys(argTypes),
    components: { MyText },
    template: '<my-text v-bind="$props" />',
});

export const Primary = Template.bind({});
Primary.args = {
    color: 'pink'
};