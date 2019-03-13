Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15721C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 22:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48E82146E
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 22:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552517005;
	bh=7KjrVbqvN7Fja0wUJEvobWPWEE8XOHR/+Za/Ed9QAJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pN7RmOp4nqSgcJt1ar7PpgEavUL5UXoioa2xQVsc4AorHZwN3YKPVYXEtZM9xV4X0
	 P5k3D7IB15of8YtXtpt0ywSWciLUw2RTxUXUGK49qBtU/bI89zMhaQSPY1LJGJYZto
	 OlNLuc3k6VeOIdjADBlpjjZt69GmUPWaaL7SHq2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfCMWnZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfCMWnZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 18:43:25 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C182087C;
        Wed, 13 Mar 2019 22:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552517004;
        bh=7KjrVbqvN7Fja0wUJEvobWPWEE8XOHR/+Za/Ed9QAJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TOxO7ih1pa82e8vEAsv/1ZZUOigSEUcOJ66gDlHtHzgo1SKOsyWoz28ONPdiD5V9M
         jR+7FHzMHkOZMRjENEnIvuwXVTWoC9uq93VoN1aMvq4hd0igVsRk8S/hAN9H0c643f
         PayOZxJMXTdEF4McgYzzyQlOSygr+6ZRxIpxelIA=
Date:   Thu, 14 Mar 2019 07:43:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] tracing/probe: Check maxactive error cases
Message-Id: <20190314074320.0ec13cf5b4b9e2261f2d5b78@kernel.org>
In-Reply-To: <20190313105156.7f1da539@gandalf.local.home>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
        <155248006270.10815.14600382508884855084.stgit@devnote2>
        <20190313092051.77d04675@gandalf.local.home>
        <20190313233739.09f58a0c5762d9a43470046b@kernel.org>
        <20190313105156.7f1da539@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 13 Mar 2019 10:51:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 13 Mar 2019 23:37:39 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> 
> > > So now 'p1:..." will error out and not just be ignored?  
> > 
> > Yes, I think it is better to tell user "your command has a
> > meaningless option, maybe you made a mistake" than ignore that.
> > 
> 
> OK, just making sure. Hope nobody complains about it ;-)
> 
> Are these OK to add for the next merge window, or do you want them in
> now? I could probably get them ready for -rc1.

Yes, I think [1/7] to [3/7] would be better to go to 5.1.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
