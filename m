Return-Path: <SRS0=JZDS=42=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE51C10F27
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 12:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A7520828
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 12:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FitkCStb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCIMaQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:30:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29060 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726368AbgCIMaQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Mar 2020 08:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583757014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebGO8qzS08nLoHY9efPyDFqQBRih0G2tqEyxSONaxo4=;
        b=FitkCStbzu7ycdcQsFrw0Hdy8GOnYC/mfJ6bBfyCNKSxgH0KMC/Cba7JUlPL6YV73+4ati
        qsHYC4sbzqxibWDmId1bpq0MpbNqX7TT8+JXRDbmMgDXFFOnAWwpoiLUO8AV9QXBhzC88a
        W28l46Z9e0lfHMcOWFMSrbwCcd9LPz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-A_mlbDNQPvaO1lgNIfG9iw-1; Mon, 09 Mar 2020 08:30:13 -0400
X-MC-Unique: A_mlbDNQPvaO1lgNIfG9iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A00E19251A7;
        Mon,  9 Mar 2020 12:30:11 +0000 (UTC)
Received: from krava (ovpn-205-150.brq.redhat.com [10.40.205.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8287B2898C;
        Mon,  9 Mar 2020 12:30:09 +0000 (UTC)
Date:   Mon, 9 Mar 2020 13:30:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH RT v2] tracing: make preempt_lazy and migrate_disable
 counter smaller
Message-ID: <20200309123006.GC67774@krava>
References: <20200221153541.681468-1-jolsa@kernel.org>
 <20200221104922.5ea8bb5f@gandalf.local.home>
 <20200221161030.GC657629@krava>
 <20200221112152.031b4230@gandalf.local.home>
 <20200221163735.53wt2fqoajcuj2js@linutronix.de>
 <20200221174419.7r5zxfkvz4yrndi2@linutronix.de>
 <20200221204957.GE657629@krava>
 <20200224100104.sbupmfe2oehmsrrb@linutronix.de>
 <20200224115403.GD16664@krava>
 <20200224170101.qvxapdecp5vsbwrw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224170101.qvxapdecp5vsbwrw@linutronix.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Feb 24, 2020 at 06:01:01PM +0100, Sebastian Andrzej Siewior wrote=
:
> The migrate_disable counter should not exceed 255 so it is enough to
> store it in an 8bit field.
> With this change we can move the `preempt_lazy_count' member into the
> gap so the whole struct shrinks by 4 bytes to 12 bytes in total.
> Remove the `padding' field, it is not needed.
> Update the tracing fields in trace_define_common_fields() (it was
> missing the preempt_lazy_count field).
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1=E2=80=A6v2:
>   - drop the `padding' member
>   - update the members in trace_define_common_fields() to match struct
>     trace_entry.

seems ok to me.. not sure we care, but just wanted to point out
that there's a 'not described gap' in the sched_wakeup's format
file and probably in other formats as well:

	# cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/format
	name: sched_wakeup
	ID: 310
	format:
		field:unsigned short common_type;       offset:0;       size:2; signed:=
0;
		field:unsigned char common_flags;       offset:2;       size:1; signed:=
0;
		field:unsigned char common_preempt_count;       offset:3;       size:1;=
 signed:0;
		field:int common_pid;   offset:4;       size:4; signed:1;
		field:unsigned char common_migrate_disable;     offset:8;       size:1;=
 signed:0;
		field:unsigned char common_preempt_lazy_count;  offset:9;       size:1;=
 signed:0;

		field:char comm[16];    offset:12;      size:16;        signed:1;
		field:pid_t pid;        offset:28;      size:4; signed:1;
		field:int prio; offset:32;      size:4; signed:1;
		field:int success;      offset:36;      size:4; signed:1;
		field:int target_cpu;   offset:40;      size:4; signed:1;


there's "common_preempt_lazy_count" field on offset 9 with size 1:
	common_preempt_lazy_count;  offset:9;       size:1;

followed by "comm" field on offset 12:
	field:char comm[16];    offset:12;      size:16;        signed:1;


which makes 2 bytes gap in between, that might confuse some applications
like bpftrace ;-) however there's still enough data to workaround that,
so I'm ok with that

thanks,
jirka

