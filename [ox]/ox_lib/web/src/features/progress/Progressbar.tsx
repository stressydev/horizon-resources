import React from 'react';
import { Box, createStyles, Text } from '@mantine/core';
import { useNuiEvent } from '../../hooks/useNuiEvent';
import { fetchNui } from '../../utils/fetchNui';
import ScaleFade from '../../transitions/ScaleFade';
import type { ProgressbarProps } from '../../typings';

const useStyles = createStyles((theme) => ({
  wrapper: {
    width: '100%',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    position: 'fixed',
    bottom: '5%',
    left: 0,
    right: 0,
    margin: '0 auto',
    zIndex: 5,
  },
  container: {
    width: 350,
    borderRadius: theme.radius.sm,
    overflow: 'hidden',
    padding: '6px 10px',
  },
  header: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 6,
  },
  label: {
    fontSize: 16,
    fontWeight: 700,
    color: theme.white,
  },
  percentage: {
    fontSize: 16,
    fontWeight: 700,
    color: '#8A2BE2', // bright purple (BlueViolet)
    textShadow: '0 0 6px rgba(138,43,226,0.7)', // subtle glow
  },
  barContainer: {
    background: `repeating-linear-gradient(
      135deg,
      rgba(130, 134, 134, 0.5) 1.4px,
      transparent 3px,
      transparent 4px
    )`,
    height: 8,
    borderRadius: 4,
    position: 'relative',
  },
  bar: {
    backgroundColor: '#6A0DAD', // royal purple
    height: '100%',
    borderRadius: 4,
    boxShadow: '0px 0px 20px rgba(106,13,173,0.7)', // modern purple glow
    transition: 'width 0.3s ease-out',
  },
}));


const Progressbar: React.FC = () => {
  const { classes } = useStyles();
  const [visible, setVisible] = React.useState(false);
  const [label, setLabel] = React.useState('');
  const [duration, setDuration] = React.useState(0);
  const [percent, setPercent] = React.useState(0);

  useNuiEvent('progressCancel', () => setVisible(false));

  useNuiEvent<ProgressbarProps>('progress', (data) => {
    setVisible(true);
    setLabel(data.label);
    setDuration(data.duration);

    // Example: simulate percentage increment
    let start = 0;
    const step = 100 / (data.duration / 100);
    const interval = setInterval(() => {
      start += step;
      if (start >= 100) {
        start = 100;
        clearInterval(interval);
      }
      setPercent(Math.floor(start));
    }, 100);
  });

  return (
    <Box className={classes.wrapper}>
      <ScaleFade visible={visible} onExitComplete={() => fetchNui('progressComplete')}>
        <Box className={classes.container}>
          {/* Header row with label and percentage */}
          <Box className={classes.header}>
            <Text className={classes.label}>{label}</Text>
            <Text className={classes.percentage}>{percent}%</Text>
          </Box>

          {/* Progress bar */}
          <Box className={classes.barContainer}>
            <Box
              className={classes.bar}
              style={{ width: `${percent}%` }}
              onTransitionEnd={() => percent === 100 && setVisible(false)}
            />
          </Box>
        </Box>
      </ScaleFade>
    </Box>
  );
};

export default Progressbar;
