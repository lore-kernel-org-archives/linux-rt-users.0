Return-Path: <SRS0=DFOT=3T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE396C33CB2
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jan 2020 03:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC092063A
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jan 2020 03:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgA3DBF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 22:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgA3DBE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 22:01:04 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CBF22063A;
        Thu, 30 Jan 2020 03:01:03 +0000 (UTC)
Date:   Wed, 29 Jan 2020 22:01:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 07/12] tracing: Add synth_event_trace() and related
 functions
Message-ID: <20200129220102.643ebcd4@rorschach.local.home>
In-Reply-To: <1580338724.6220.17.camel@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
        <7a84de5f1854acf4144b57efe835ca645afa764f.1580323897.git.zanussi@kernel.org>
        <20200129160915.4ebe0f08@gandalf.local.home>
        <1580338724.6220.17.camel@kernel.org>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 29 Jan 2020 16:58:44 -0600
Tom Zanussi <zanussi@kernel.org> wrote:


> Let me know if it's something else you're referring to, or if you want
> me to do a v5 or a follow-on patch to do the first part above.
>

At this point, please send a follow-on patch.

Thanks!

-- Steve
