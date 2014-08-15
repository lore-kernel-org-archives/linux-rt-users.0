From: John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH] fix the broken 'e' command line argument of
 cyclictest
Date: Fri, 15 Aug 2014 14:38:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1408151436160.25171@riemann>
References: <20140814192121.29e1baa4@alchemy.lu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Joakim Hernberg <jbh@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:51242 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbaHOMig (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Aug 2014 08:38:36 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so2275253wgg.12
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Aug 2014 05:38:35 -0700 (PDT)
In-Reply-To: <20140814192121.29e1baa4@alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 14 Aug 2014, Joakim Hernberg wrote:

> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 4547831..c54972b 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1232,7 +1232,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
>                         {"help",             no_argument,       NULL, OPT_HELP },
>                         {NULL, 0, NULL, 0}
>                 };
> -               int c = getopt_long(argc, argv, "a::A::b:Bc:Cd:D:Efh:H:i:Il:MnNo:O:p:PmqrRsSt::uUvD:wWT:",
> +               int c = getopt_long(argc, argv, "a::A::b:Bc:Cd:D:e:Efh:H:i:Il:MnNo:O:p:PmqrRsSt::uUvD:wWT:",
>                                     long_options, &option_index);
>                 if (c == -1)
>                         break;
> @@ -1280,6 +1280,14 @@ static void process_options (int argc, char *argv[], int max_cpus)
>                 case 'D':
>                 case OPT_DURATION:
>                         duration = parse_time_string(optarg); break;
> +               case 'e':
> +               case OPT_LATENCY:
> +                       /* power management latency target value */
> +                       /* note: default is 0 (zero) */
> +                       latency_target_value = atoi(optarg);
> +                       if (latency_target_value < 0)
> +                               latency_target_value = 0;
> +                       break;
>                 case 'E':
>                 case OPT_EVENT:
>                         enable_events = 1; break;
> @@ -1421,13 +1429,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
>                 /* long only options */
>                 case OPT_PRIOSPREAD:
>                         priospread = 1; break;
> -               case OPT_LATENCY:
> -                          /* power management latency target value */
> -                         /* note: default is 0 (zero) */
> -                       latency_target_value = atoi(optarg);
> -                       if (latency_target_value < 0)
> -                               latency_target_value = 0;
> -                       break;
>                 case OPT_NOTRACE:
>                         notrace = 1; break;
>                 case OPT_POLICY:
> 
> --

As you noticed yourself and mentioned to me on IRC - this patch isn't 
necessary. The problem here is because we tried to removed a bunch of
short options to simplify cyclictest, so the fix is to remove the 
short option from the help instead of trying to put it back. :)
(and I sent a patch that doesn this)

Thanks

John
