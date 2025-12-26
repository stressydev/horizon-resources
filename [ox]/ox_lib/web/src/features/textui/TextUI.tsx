import React from 'react';
import { useNuiEvent } from '../../hooks/useNuiEvent';
import { Box, createStyles, keyframes } from '@mantine/core';
import ReactMarkdown from 'react-markdown';
import ScaleFade from '../../transitions/ScaleFade';
import remarkGfm from 'remark-gfm';
import type { TextUiPosition, TextUiProps } from '../../typings';
import MarkdownComponents from '../../config/MarkdownComponents';
import LibIcon from '../../components/LibIcon';
import { useGlassStyle } from '../../hooks/useGlassStyle';

const breathe = keyframes({
  '0%, 100%': { transform: 'scale(1)', opacity: 1 },
  '50%': { transform: 'scale(1.005)', opacity: 0.95 },
});

const slideInScale = keyframes({
  '0%': { transform: 'translateY(-20px) scale(0.8)', opacity: 0 },
  '60%': { transform: 'translateY(5px) scale(1.05)', opacity: 0.9 },
  '100%': { transform: 'translateY(0px) scale(1)', opacity: 1 },
});

const slideOutScale = keyframes({
  '0%': { transform: 'translateY(0px) scale(1)', opacity: 1 },
  '100%': { transform: 'translateY(-20px) scale(0.85)', opacity: 0 },
});

const useStyles = createStyles((theme, params: { position?: TextUiPosition }) => {
  const glass = useGlassStyle();

  return {
    wrapper: {
      height: '100%',
      width: '100%',
      position: 'absolute',
      display: 'flex',
      alignItems:
        params.position === 'top-center' ? 'flex-start' :
        params.position === 'bottom-center' ? 'flex-end' : 'center',
      justifyContent:
        params.position === 'right-center' ? 'flex-end' :
        params.position === 'left-center' ? 'flex-start' : 'center',
      padding: '20px',
      pointerEvents: 'none',
    },
    container: {
      position: 'relative',
      fontFamily: 'Roboto',
      background: glass.isDarkMode ? glass.mainBackground : glass.lightBackground,
      border: glass.border,
      boxShadow: glass.shadow,
      // borderRadius: '12px',
      padding: '16px 20px',
      minWidth: '200px',
      maxWidth: '400px',
      animation: `${breathe} 3s ease-in-out infinite`,
    },
    corner: {
      position: 'absolute',
      width: 14,
      height: 14,
      pointerEvents: 'none',
    },
    contentWrapper: {
      display: 'flex',
      alignItems: 'center',
      gap: '10px',
      position: 'relative',
      zIndex: 2,
    },
    iconContainer: {
      position: 'relative',
      flexShrink: 0,
      display: 'flex',
      alignItems: 'center',
    },
    iconGlow: {
      position: 'absolute',
      top: 0,
      left: 0,
      width: '100%',
      height: '100%',
      // borderRadius: '50%',
      opacity: 0.15,
      filter: 'blur(12px)',
      zIndex: -1,
      animation: `${breathe} 2.5s ease-in-out infinite`,
    },
    textContent: {
      flex: 1,
      minWidth: 0,
      fontSize: '17px',
      color: 'rgba(255, 255, 255, 0.9)',
      fontFamily: 'Roboto',
      lineHeight: 1.5,
      fontWeight: 500,
      textAlign: 'center',
    },
    textContentNoIcon: {
      width: '100%',
      textAlign: 'center',
    },
  };
});

const TextUI: React.FC = () => {
  const [data, setData] = React.useState<TextUiProps>({
    text: '',
    position: 'right-center',
  });
  const [visible, setVisible] = React.useState(false);
  const { classes, cx } = useStyles({ position: data.position });

  useNuiEvent<TextUiProps>('textUi', (incoming) => {
    if (!incoming.position) incoming.position = 'right-center';
    setData(incoming);
    setVisible(true);
  });

  useNuiEvent('textUiHide', () => setVisible(false));

  return (
    <Box className={classes.wrapper}>
      <ScaleFade visible={visible}>
        <Box style={data.style} className={cx(classes.container)}>
          {/* Corner accents */}
          <span
            className={classes.corner}
            style={{ top: 0, left: 0, borderTop: '2px solid rgba(255,255,255,0.6)', borderLeft: '2px solid rgba(255,255,255,0.6)' }}
          />
          <span
            className={classes.corner}
            style={{ top: 0, right: 0, borderTop: '2px solid rgba(255,255,255,0.6)', borderRight: '2px solid rgba(255,255,255,0.6)' }}
          />
          <span
            className={classes.corner}
            style={{ bottom: 0, left: 0, borderBottom: '2px solid rgba(255,255,255,0.6)', borderLeft: '2px solid rgba(255,255,255,0.6)' }}
          />
          <span
            className={classes.corner}
            style={{ bottom: 0, right: 0, borderBottom: '2px solid rgba(255,255,255,0.6)', borderRight: '2px solid rgba(255,255,255,0.6)' }}
          />

          <div className={classes.contentWrapper}>
            {data.icon && (
              <div className={classes.iconContainer}>
                <div
                  className={classes.iconGlow}
                  style={{ background: data.iconColor || '#ffffff' }}
                />
                <LibIcon
                  icon={data.icon}
                  fixedWidth
                  size="lg"
                  animation={data.iconAnimation}
                  style={{
                    color: data.iconColor || '#ffffff',
                    filter: 'drop-shadow(0 2px 4px rgba(0, 0, 0, 0.5))',
                    fontSize: '20px',
                  }}
                />
              </div>
            )}
            <div className={cx(classes.textContent, !data.icon && classes.textContentNoIcon)}>
              <ReactMarkdown components={MarkdownComponents} remarkPlugins={[remarkGfm]}>
                {data.text}
              </ReactMarkdown>
            </div>
          </div>
        </Box>
      </ScaleFade>
    </Box>
  );
};

export default TextUI;
