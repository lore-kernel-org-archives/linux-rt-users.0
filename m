Return-Path: <SRS0=pHM8=RH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6AAC43381
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 21:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43F020823
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 21:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfCDVuD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCDVuD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Mar 2019 16:50:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B889206B6;
        Mon,  4 Mar 2019 21:50:02 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:50:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/2] tracing: Use strncpy instead of memcpy for string
 keys in hist triggers
Message-ID: <20190304165000.0ce0fbdd@gandalf.local.home>
In-Reply-To: <50c35ae1267d64eee975b8125e151e600071d4dc.1549309756.git.tom.zanussi@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
        <50c35ae1267d64eee975b8125e151e600071d4dc.1549309756.git.tom.zanussi@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon,  4 Feb 2019 15:07:24 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Because there may be random garbage beyond a string's null terminator,
> it's not correct to copy the the complete character array for use as a
> hist trigger key.  This results in multiple histogram entries for the
> 'same' string key.
> 
> So, in the case of a string key, use strncpy instead of memcpy to
> avoid copying in the extra bytes.
> 
> Before, using the gdbus entries in the following hist trigger as an
> example:
> 
>   # echo 'hist:key=comm' > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
>   # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist
> 
>   ...
> 
>   { comm: ImgDecoder #4                      } hitcount:        203
>   { comm: gmain                              } hitcount:        213
>   { comm: gmain                              } hitcount:        216
>   { comm: StreamTrans #73                    } hitcount:        221
>   { comm: mozStorage #3                      } hitcount:        230
>   { comm: gdbus                              } hitcount:        233
>   { comm: StyleThread#5                      } hitcount:        253
>   { comm: gdbus                              } hitcount:        256
>   { comm: gdbus                              } hitcount:        260
>   { comm: StyleThread#4                      } hitcount:        271
> 
>   ...
> 
>   # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist | egrep gdbus | wc -l
>   51
> 
> After:
> 
>   # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist | egrep gdbus | wc -l
>   1
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/trace/trace_events_hist.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c4a667503bf0..1b349689b897 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4695,9 +4695,10 @@ static inline void add_to_key(char *compound_key, void *key,
>  		/* ensure NULL-termination */
>  		if (size > key_field->size - 1)
>  			size = key_field->size - 1;
> -	}
>  
> -	memcpy(compound_key + key_field->offset, key, size);
> +		strncpy(compound_key + key_field->offset, (char *)key, size);
> +	} else
> +		memcpy(compound_key + key_field->offset, key, size);
>  }
>  

Shouldn't we use strncpy() in save_comm() too. Feels safer.

-- Steve
