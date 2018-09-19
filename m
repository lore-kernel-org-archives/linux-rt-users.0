Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43460 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbeISUTW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Sep 2018 16:19:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so6066858wre.10
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Sep 2018 07:41:07 -0700 (PDT)
Date: Wed, 19 Sep 2018 16:41:04 +0200 (CEST)
From: John Kacur <jkacur@redhat.com>
Subject: Re: [patch 2/2] Add queuelat manpage
In-Reply-To: <20180904115701.634017140@redhat.com>
Message-ID: <alpine.LFD.2.21.1809191640160.6250@planxty>
References: <20180904115633.410153367@redhat.com> <20180904115701.634017140@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>



On Tue, 4 Sep 2018, Marcelo Tosatti wrote:

> Add a man page for queuelat, with a short introduction
> and description for each option.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  src/queuelat/queuelat.8 |   59 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> Index: rt-tests/src/queuelat/queuelat.8
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ rt-tests/src/queuelat/queuelat.8	2018-09-03 17:55:39.956071513 -0300
> @@ -0,0 +1,59 @@
> +.\"                                      Hey, EMACS: -*- nroff -*-
> +.TH QUEUELAT 8 "Sept 3, 2018"
> +.\" Please adjust this date whenever revising the manpage.
> +.\"
> +.\" Some roff macros, for reference:
> +.\" .nh        disable hyphenation
> +.\" .hy        enable hyphenation
> +.\" .ad l      left justify
> +.\" .ad b      justify to both left and right margins
> +.\" .nf        disable filling
> +.\" .fi        enable filling
> +.\" .br        insert line break
> +.\" .sp <n>    insert n+1 empty lines
> +.\" for manpage-specific macros, see man(7)
> +.SH NAME
> +queuelat \- Queue latency test program
> +.SH SYNOPSIS
> +.B queuelat
> +.RI "[\-h] [\-m " max-queue-len "] [\-c " cycles-per-packet "] [\-p " mpps "] [\-f " tsc-freq "] [\-t " timeout "] \
> +
> +.SH DESCRIPTION
> +queuelat simulates a network queue checking for latency
> +violations in packet processing.
> +
> +.SH OPTIONS
> +A summary of options is included below.
> +.TP
> +.B \-h
> +Show help
> +.br
> +.TP
> +.B \-m max-queue-len
> +Maximum allowed latency, in nanoseconds. If latency to process
> +.br
> +any packet exceeds this value, the program quits,
> +writing
> +.br
> +a message to the trace buffer.
> +.TP
> +.B \-c cycles-per-packet
> +Estimated number of cycles it takes to process one packet.
> +.br
> +This value should come from the envisioned packet
> +.br
> +forwarding application being simulated.
> +.TP
> +.B \-p mpps
> +Million packets per second that arrive for processing.
> +.TP
> +.B \-f tsc-freq-mhz
> +TSC frequency in MHz.
> +.TP
> +.B \-t timeout
> +Timeout in seconds to quit the program.
> +
> +
> +.SH AUTHOR
> +queuelat was written by Marcelo Tosatti <mtosatti@redhat.com>
> +.br
> 
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
