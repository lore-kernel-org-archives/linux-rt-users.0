From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] no compile warnings from cyclictest
Date: Thu, 8 Jun 2017 16:26:24 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1706081622010.5309@riemann>
References: <trinity-e47892ae-17fb-4f87-8381-f313303cfe09-1496484084736@3capp-webde-bs10>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463806030-1273429906-1496931985=:5309"
Cc: linux-rt-users@vger.kernel.org
To: rolf.freitag@email.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36714 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdFHO02 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2017 10:26:28 -0400
Received: by mail-wm0-f53.google.com with SMTP id 7so139125253wmo.1
        for <linux-rt-users@vger.kernel.org>; Thu, 08 Jun 2017 07:26:28 -0700 (PDT)
In-Reply-To: <trinity-e47892ae-17fb-4f87-8381-f313303cfe09-1496484084736@3capp-webde-bs10>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806030-1273429906-1496931985=:5309
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 3 Jun 2017, rolf.freitag@email.de wrote:

> Hi,
> 
> compiling cyclictest gives 4 warnings of type
> 
>   warning: ignoring return value of 'write'
> 
> and three of type
> 
>   warning: ... may be used uninitialized in this function
> 
> So i eleminated the first sort with a trash variable, which adds up 
> the return values and recycles them (their entropy) at the end via
> srand(). This also avoids a write-only variable.
> I eleminated the second sort by initializing the variables.
> 
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -222,6 +222,7 @@ static int use_fifo = 0;
>  static pthread_t fifo_threadid;
>  static int laptop = 0;
>  static int use_histfile = 0;
> +static unsigned int trash; // for unused return values, to avoid compiler warnings because of ignored return values
>  
>  #ifdef ARCH_HAS_SMI_COUNTER
>  static int smi = 0;
> @@ -491,10 +492,10 @@ static void tracemark(char *fmt, ...)
>         va_end(ap);
>  
>         /* write the tracemark message */
> -       write(tracemark_fd, tracebuf, len);
> +       trash += write(tracemark_fd, tracebuf, len);
>  
>         /* now stop any trace */
> -       write(trace_fd, "0\n", 2);
> +       trash += write(trace_fd, "0\n", 2);
>  }
>  
>  
> @@ -510,7 +511,7 @@ static void tracing(int on)
>                 case KV_26_LT24: prctl(0, 1); break;
>                 case KV_26_33:
>                 case KV_30:
> -                       write(trace_fd, "1", 1);
> +                       trash += write(trace_fd, "1", 1);
>                         break;
>                 default:         break;
>                 }
> @@ -520,7 +521,7 @@ static void tracing(int on)
>                 case KV_26_LT24: prctl(0, 0); break;
>                 case KV_26_33:
>                 case KV_30:
> -                       write(trace_fd, "0", 1);
> +                       trash += write(trace_fd, "0", 1);
>                         break;
>                 default:        break;
>                 }
> @@ -984,8 +985,10 @@ static void *timerthread(void *param)
>         int stopped = 0;
>         cpu_set_t mask;
>         pthread_t thread;
> -       unsigned long smi_now, smi_old;
> +       unsigned long smi_now, smi_old=0;
>  
> +    memset(&stop, 0, sizeof(stop)); /* grrr */
> +    
>         /* if we're running in numa mode, set our memory node */
>         if (par->node != -1)
>                 rt_numa_set_numa_run_on_node(par->node, par->cpu);
> @@ -1066,7 +1069,6 @@ static void *timerthread(void *param)
>         tsnorm(&next);
>  
>         if (duration) {
> -               memset(&stop, 0, sizeof(stop)); /* grrr */
>                 stop = now;
>                 stop.tv_sec += duration;
>         }
> @@ -2623,5 +2625,7 @@ int main(int argc, char **argv)
>         if (affinity_mask)
>                 rt_bitmask_free(affinity_mask);
>  
> +    srand(trash); // recycling of the trash (unused return values)
> +    
>         exit(ret);
>  }
> --

I seen to recall some old conversations on lkml where these kind of
patches to supress compiler warnings were considered worse than the 
warnings. It is possible to supress warnings that we need to deal with.
In addition I see that some of your patch touches on tracing, which
I'm planning on ripping out and replacing with the ability to do the same
kind of tracing with external programs, specifically trace-cmd.

Thanks

John
---1463806030-1273429906-1496931985=:5309--
