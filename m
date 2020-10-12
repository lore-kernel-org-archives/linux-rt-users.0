Return-Path: <SRS0=LljW=DT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99F7C433E7
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 08:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FCF208B6
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 08:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdiCPTEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgJLIO4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Oct 2020 04:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729180AbgJLIO4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Oct 2020 04:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602490494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVMTNfZPhpmjUvWqwlb2u6mv5fmTTCfQRSLZkL9cblY=;
        b=NdiCPTEwsFGEICD2NSeOgj7BR0YDOsCh/Wma2DtL5LVcpc9QPh76I1twoYbh2eerA6e0Y3
        hoW6uch8JloYo8yBXkTMQK258gV5W8Y1FzO6tf0Q9QBp7qPidnuTUt9WNl17YHcTG8a4xk
        gjaVIOBqnTPLWsbm3dnYnV+PEPxizm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-eLkQHV8xPPyqrp4SGbLINA-1; Mon, 12 Oct 2020 04:14:52 -0400
X-MC-Unique: eLkQHV8xPPyqrp4SGbLINA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF4F418BE164;
        Mon, 12 Oct 2020 08:14:50 +0000 (UTC)
Received: from [10.36.112.220] (ovpn-112-220.ams2.redhat.com [10.36.112.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1C285C22A;
        Mon, 12 Oct 2020 08:14:43 +0000 (UTC)
From:   "Eelco Chaudron" <echaudro@redhat.com>
To:     "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc:     "Juri Lelli" <juri.lelli@redhat.com>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com, atheurer@redhat.com
Subject: Re: [PATCH 5.9 RT] net: openvswitch: Fix using smp_processor_id() in
 preemptible code
Date:   Mon, 12 Oct 2020 10:14:42 +0200
Message-ID: <65BBD0B4-2A74-421A-BF81-357CD5F84747@redhat.com>
In-Reply-To: <20201009154116.a4fcrrm7flxonidd@linutronix.de>
References: <20201009124759.592550-1-juri.lelli@redhat.com>
 <20201009154116.a4fcrrm7flxonidd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 9 Oct 2020, at 17:41, Sebastian Andrzej Siewior wrote:

> On 2020-10-09 14:47:59 [+0200], Juri Lelli wrote:
>> This happens because openvswitch/flow_table::flow_lookup() accesses
>> per-cpu data while being preemptible (and migratable).
>>
>> Fix it by adding get/put_cpu_light(), so that, even if preempted, the
>> task executing this code is not migrated (operation is also guarded 
>> by
>> ovs_mutex mutex).
>
> This warning is not limited to PREEMPT_RT it also present upstream 
> since
> commit
>    eac87c413bf97 ("net: openvswitch: reorder masks array based on 
> usage")
>
> You should be able to reproduce it there, too.
> The path ovs_flow_tbl_lookup() -> flow_lookup() is guarded by 
> ovs_lock()
> I can't say that this true for
>    ovs_vport_receive() -> ovs_dp_process_packet() ->
>    ovs_flow_tbl_lookup_stats() -> flow_lookup()
>
> (means I don't know but it looks like coming from NAPI).
>
> Which means u64_stats_update_begin() could have two writers. This must
> not happen.
> There are two reader which do u64_stats_fetch_begin_irq(). Disabling
> interrupts makes no sense since they perform cross-CPU access.
>
> -> You need to ensure that there is only one writer at a time.
>
> If mask_array gains a spinlock_t for writer protection then you can
> acquire the lock prio grabbing ->masks_usage_cntr. But as of now there
> is one `ma->syncp'.

I’m not too familiar with the RT kernel, but in the none RT kernel, 
this function is called in run to completion parts only, hence does not 
need a lock. Actually, this was designed in such a way that it does not 
need a lock at all.

So maybe this needs a get_cpu() instead of the light variant in the RT 
case?

//Eelco

