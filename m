Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16677C35669
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 20:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6114206EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 20:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDxJ2bEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBUUuK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:50:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39565 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgBUUuJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 15:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582318208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PW4bV9owzCR0GrgSI7FyXhQJGcIlBlHHH9mjBSVotEs=;
        b=XDxJ2bEVsHBgbQDeV8zKM+lgYXnVkfCc9ge1rC9hgR00LvakH0AylkZz9m7iQHuhTWBZJp
        11Otus4E+FAh/O0aK/bpA9bRRt/aD3Pe9nbGI95ACVE+Y7x2P3uOEClIs0V58NA0zEIhfL
        TcK5sGDoB6u3tTcAVwdbs5oJx8SAdCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-XwUH1Eu0PoGYWJzsQ7-TUA-1; Fri, 21 Feb 2020 15:50:07 -0500
X-MC-Unique: XwUH1Eu0PoGYWJzsQ7-TUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71CC2800D4E;
        Fri, 21 Feb 2020 20:50:05 +0000 (UTC)
Received: from krava (ovpn-204-57.brq.redhat.com [10.40.204.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90CC65C1D4;
        Fri, 21 Feb 2020 20:50:00 +0000 (UTC)
Date:   Fri, 21 Feb 2020 21:49:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH RT] tracing: make preempt_lazy and migrate_disable
 counter smaller
Message-ID: <20200221204957.GE657629@krava>
References: <20200221153541.681468-1-jolsa@kernel.org>
 <20200221104922.5ea8bb5f@gandalf.local.home>
 <20200221161030.GC657629@krava>
 <20200221112152.031b4230@gandalf.local.home>
 <20200221163735.53wt2fqoajcuj2js@linutronix.de>
 <20200221174419.7r5zxfkvz4yrndi2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221174419.7r5zxfkvz4yrndi2@linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Feb 21, 2020 at 06:44:19PM +0100, Sebastian Andrzej Siewior wrote:
> The migrate_disable counter should not exceed 255 so it is enough to
> store it in an 8bit field.
> With this change we can move the `preempt_lazy_count' member into the
> gap so the whole struct shrinks by 4 bytes to 12 bytes in total.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/trace_events.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index f3b1ef07e4a5f..c8b3f06cb5ed7 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -62,9 +62,9 @@ struct trace_entry {
>  	unsigned char		flags;
>  	unsigned char		preempt_count;
>  	int			pid;
> -	unsigned short		migrate_disable;
> -	unsigned short		padding;
> +	unsigned char		migrate_disable;
>  	unsigned char		preempt_lazy_count;
> +	unsigned short		padding;

also we still need to put preempt_lazy_count as common field:

	__common_field(unsigned char,  preempt_lazy_count);

jirka

