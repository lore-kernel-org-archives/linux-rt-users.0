Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA3CC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 16:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F122E60F35
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 16:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhJKQiG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhJKQiF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Oct 2021 12:38:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920ADC061570;
        Mon, 11 Oct 2021 09:36:05 -0700 (PDT)
Date:   Mon, 11 Oct 2021 18:36:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633970163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsRBg2JVgw9RsTfgfDHVpkKTEf10BedReqnhJcE9AOg=;
        b=loodREZhVTuP0AlItE9TdyjMqxUeMjE0fb40DeuRC4503KsSIB6lWOE6ZYmif5nOCVSEWa
        rWuHr0hXT1L4F+CmtMuyjhpAUJU0gOjqIymCDjK6LpWXRAcdRoV7NG7J72NA23A3OZOiWW
        W+bC9JtF6GrKkydvML2AZJ8+MFTX/Y1gvd3IGes3kh7/CZXvbPPowpjII95oPchmpCCGR5
        qvxbtS4Q0QzcsgCOr73Z+AVnwf7nMwF/5YdTP2YES8rsGoY+RRjvqFH83dDVP3Ksbz30Wr
        oelcukW8WHxXO70kBJLP+Z3YFhByZd7US9S5EbRgvWn7r5MrXN80G2e5Q6fheg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633970163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsRBg2JVgw9RsTfgfDHVpkKTEf10BedReqnhJcE9AOg=;
        b=6P9aRpxtPn72UE+t7dQzSgayVHq1g2+1NYhXXdtYs1GfcXD2mt2lzruj1wtV+oqFKM/eTl
        p3+gBJHxPJnmmSAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Nitesh Narayan Lal <nilal@redhat.com>,
        Pei Zhang <pezhang@redhat.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of dev_base_lock in
 netstat_show()
Message-ID: <20211011163601.m6j3ibb7ydeevpiz@linutronix.de>
References: <YVuviZ3F7MbPvleo@uudg.org>
 <20211011135609.22y7hkycbqm52w6d@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211011135609.22y7hkycbqm52w6d@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-11 15:56:09 [+0200], To Luis Claudio R. Goncalves wrote:
> So my guess is that the _bh isn't needed.

Correction: If there is at least _one_ reader in softirq all, writer
need to disable BH which _might_ be the case here.
The splat is probably because on read_lock holder disables BH later on
which I don't see yet.

Sebastian
