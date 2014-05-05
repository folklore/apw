# Be sure to restart your server when you modify this file.

Wiki::Application.config.session_store :redis_store,
                                        'redis://rediscloud:gPEkF8hDmFzxhnpP@pub-redis-14541.us-east-1-3.1.ec2.garantiadata.com:14541',
                                        { expires_in: 90.minutes }
