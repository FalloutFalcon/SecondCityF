import { CheckboxInput, type FeatureToggle } from '../base';

export const show_identity_when_masked: FeatureToggle = {
  name: 'Show Identity When Masked',
  description:
    'While toggled and masked, everyone will be able to see your flavor text and your name if they know it.',
  component: CheckboxInput,
};
