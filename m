Return-Path: <SRS0=MKa8=2J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C17C43603
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Dec 2019 14:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FFD21655
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Dec 2019 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576766720;
	bh=bCCo+hOXEo4/4oZ31QJdcXaJpto/tB/FgXaHfiQrrQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Fk0n0zJ4qzQq+iGfmyV8m+cZJeHw1RTRAWPWQuRKiGKcQ3CcT8MIlCFSiAs/Da/Gt
	 oI/ZUamogG2fdbc2gDN92f5DmBfNR2ZFoaJVPzGG/JU7M9xuWcgTNxJdIyBYVmV6KY
	 i7SCAJxlhHLjWxkmU4S5Ey2PPtvPzXrX19vBxfXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLSOpQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfLSOpQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Dec 2019 09:45:16 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA022053B;
        Thu, 19 Dec 2019 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576766715;
        bh=bCCo+hOXEo4/4oZ31QJdcXaJpto/tB/FgXaHfiQrrQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sfhRZ9v6nevvzS6fIZTaZisueikhld0y38ZV0OiHmQTpn6HQ7VnNYgOQar06oqo1f
         9i+7fVex2ROO+XavUzzfGZqkDpt8aKcii/y+zFDl4Ghmj0phmEKF8tPbL04cXQd1Iw
         DnVlghKMx4x65eRSkCU4Blqhr6AAYONft7QAAPYg=
Date:   Thu, 19 Dec 2019 23:45:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/7] tracing: Add support for in-kernel synthetic event
 API
Message-Id: <20191219234511.bb499b3d1590059506db6982@kernel.org>
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Tom,

On Wed, 18 Dec 2019 09:27:36 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi,
> 
> I've recently had several requests and suggestions from users to add
> support for the creation and generation of synthetic events from
> kernel code such as modules, and not just from the available command
> line commands.

This reminds me my recent series of patches.

Could you use synth_event_run_command() for this purpose as I did
in boot-time tracing series?

https://lkml.kernel.org/r/157528179955.22451.16317363776831311868.stgit@devnote2

Above example uses a command string as same as command string, but I think
we can introduce some macros to construct the command string for easier
definition.

Or maybe it is possible to pass the const char *args[] array to that API,
instead of single char *cmd. (for dynamic event definiton)

Maybe we should consider more generic APIs for modules to create/delete
dynamic-event including synthetic and probes, and those might reuse
existing command parsers.

> This patchset adds support for that.  The first three patches add some
> minor preliminary setup, followed by the two main patches that add the
> ability to create and generate synthetic events from the kernel.  The
> next patch adds a test module that demonstrates actual use of the API
> and verifies that it works as intended, followed by Documentation.

Could you also check the locks are correctly acquired? It seems that
your APIs doesn't lock it.


Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
