From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: RFC: patch to trigger thread stats output from cyclictest with SIGHUP
Date: Mon, 11 Mar 2013 12:25:15 -0400
Message-ID: <CAP=VYLrV7QbA_+L66WVGSYoJaF-+sh8uyw0boq8hDCkF0xrQtw@mail.gmail.com>
References: <20130311111607.587cda32@riff.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Kacur <jkacur@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>,
	David Sommerseth <davids@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33837 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab3CKQZq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Mar 2013 12:25:46 -0400
Received: by mail-wi0-f169.google.com with SMTP id l13so1232666wie.0
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Mar 2013 09:25:45 -0700 (PDT)
In-Reply-To: <20130311111607.587cda32@riff.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 11, 2013 at 12:16 PM, Clark Williams <williams@redhat.com> wrote:
> John,
>
> Steven suggested a feature for cyclictest that I'd actually been
> whining about (internally anyway). During long rteval runs there's
> really no feedback available if you want to know how the run is
> progressing. Steven suggested sending SIGHUP and dumping the current
> state. Below is a patch that seems to work for cyclictest; just
> wanted to get some feedback on whether this would be acceptable
> behaviour.

Is USR1 already in use for something?  That would be consistent with
how things like dd use USR1 signal - to report interim stats.

P.
--

>
> Of course if we get this going then we need to figure out how to wire
> it into rteval as well :).
>
> Clark
>
>
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 0a15dcb..51b97cf 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -199,6 +199,11 @@ static char **traceptr;
>  static int traceopt_count;
>  static int traceopt_size;
>
> +static struct thread_param **parameters;
> +static struct thread_stat **statistics;
> +
> +static void print_stat(struct thread_param *par, int index, int verbose);
> +
>  static int latency_target_fd = -1;
>  static int32_t latency_target_value = 0;
>
> @@ -1368,6 +1373,19 @@ static int check_timer(void)
>
>  static void sighand(int sig)
>  {
> +       if (sig == SIGHUP) {
> +               int i;
> +               int oldquiet = quiet;
> +
> +               quiet = 0;
> +               printf("#---------------------------\n");
> +               printf("# cyclictest current status:\n");
> +               for (i = 0; i < num_threads; i++)
> +                       print_stat(parameters[i], i, 0);
> +               printf("#---------------------------\n");
> +               quiet = oldquiet;
> +               return;
> +       }
>         shutdown = 1;
>         if (refresh_on_max)
>                 pthread_cond_signal(&refresh_on_max_cond);
> @@ -1503,8 +1521,6 @@ int main(int argc, char **argv)
>         sigset_t sigset;
>         int signum = SIGALRM;
>         int mode;
> -       struct thread_param **parameters;
> -       struct thread_stat **statistics;
>         int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
>         int i, ret = -1;
>         int status;
> @@ -1642,6 +1658,7 @@ int main(int argc, char **argv)
>
>         signal(SIGINT, sighand);
>         signal(SIGTERM, sighand);
> +       signal(SIGHUP, sighand);
>
>         parameters = calloc(num_threads, sizeof(struct thread_param *));
>         if (!parameters)
