import { useNuiEvent } from '../../hooks/useNuiEvent';
import { toast, Toaster } from 'react-hot-toast';
import ReactMarkdown from 'react-markdown';
import { Box, createStyles, Text } from '@mantine/core';
import React, { useCallback, useMemo, useRef } from 'react';
import type { NotificationProps } from '../../typings';
import MarkdownComponents from '../../config/MarkdownComponents';
import Glass from '../../components/Glass';
import { useGlassStyle } from '../../hooks/useGlassStyle';

const getStyleByType = (type?: string) => {
  switch (type) {
    case 'success':
      return {
        bg: 'linear-gradient(135deg, rgba(40,70,55,0.85), rgba(45,85,65,0.85))',
        corner: 'rgba(45, 85, 65, 0.9)',
      };
    case 'error':
      return {
        bg: 'linear-gradient(135deg, rgba(70,40,40,0.85), rgba(90,45,45,0.85))',
        corner: 'rgba(90, 45, 45, 0.9)',
      };
    case 'info':
    default:
      return {
        bg: 'linear-gradient(135deg, rgba(40,60,70,0.88), rgba(45,75,85,0.88))',
        corner: 'rgba(45, 75, 85, 0.9)',
      };
  }
};

const useStyles = createStyles(
  (
    theme,
    {
      glassStyle,
      bg,
      cornerColor,
    }: { glassStyle: any; bg: string; cornerColor: string }
  ) => ({
    container: {
      width: 'fit-content',
      minHeight: 'unset',
      padding: 10,                 // ✅ matches old CSS
      borderRadius: 5,             // ✅ matches old CSS
      margin: 5,                   // ✅ matches old CSS
      position: 'relative',
      overflow: 'visible',
      fontFamily: 'caption',       // ✅ matches old CSS
      fontSize: 12,                // ✅ matches old CSS
      fontWeight: 'bold',          // ✅ matches old CSS
      background: bg,
      border: `1px solid rgba(255,255,255,0.25)`,
      boxShadow: glassStyle.shadow,
    },

    corner: {
      position: 'absolute',
      width: 8,                    // ✅ smaller corners
      height: 8,
      borderColor: cornerColor,
      pointerEvents: 'none',
    },

    title: {
      fontWeight: 700,
      fontSize: 13,                // ✅ smaller
      lineHeight: 1.2,
      color: '#fff',
      marginBottom: 4,
    },

    description: {
      fontSize: 12,                // ✅ matches old CSS
      color: 'rgba(255,255,255,0.95)',
      lineHeight: 1.3,
      fontWeight: 500,
    },

    descriptionOnly: {
      fontSize: 12,                // ✅ matches old CSS
      color: '#fff',
      lineHeight: 1.3,
      fontWeight: 600,
    },
  })
);

const NotificationComponent: React.FC<{
  notification: NotificationProps;
  toastId: string;
}> = ({ notification }) => {
  const glassStyle = useGlassStyle();

  const { bg, corner } = useMemo(
    () => getStyleByType(notification.type),
    [notification.type]
  );
  const { classes } = useStyles({ glassStyle, bg, cornerColor: corner });

  return (
    <Box className={classes.container}>
      {notification.description && (
        <ReactMarkdown
          components={MarkdownComponents}
          className={
            notification.title ? classes.description : classes.descriptionOnly
          }
        >
          {notification.description}
        </ReactMarkdown>
      )}
    </Box>
  );
};

const Notifications: React.FC = () => {
  const recentNotifications = useRef<Map<string, number>>(new Map());

  const isDuplicateRecent = useCallback((data: NotificationProps): boolean => {
    if (!data.title && !data.description) return true;
    const key = `${data.title || ''}_${data.description || ''}_${data.type || ''}`;
    const now = Date.now();
    const last = recentNotifications.current.get(key);
    if (last && now - last < 200) return true;
    recentNotifications.current.set(key, now);
    return false;
  }, []);

  useNuiEvent<NotificationProps>('notify', (data) => {
    if (!data.title && !data.description) return;
    if (isDuplicateRecent(data)) return;

    toast.custom((t) => <NotificationComponent notification={data} toastId={t.id} />, {
      duration: data.duration || 4000,
      position: (data.position as any) || 'top-right',
    });
  });

  return (
    <Toaster
      toastOptions={{
        style: { background: 'transparent', boxShadow: 'none', padding: 0, margin: 0 },
      }}
      gutter={16}
    />
  );
};

export default Notifications;
