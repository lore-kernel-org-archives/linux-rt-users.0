Return-Path: <SRS0=k11Z=SD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716E1C43381
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Apr 2019 23:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF702086C
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Apr 2019 23:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554163177;
	bh=YZRcFYhEWBkLgDehzmgeUo0fhIZsW9YwoNRnvs1zKtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qa2gZ6YMMRDWPq8E+IfU8x6V8cVP4hY/q+OHc5MNAgM/+wB/+ElCEe2hAV0HobB90
	 e6sARL39EDG4tVxgZB+tDwOnh8xAEhrBRsGm9cj9pQ8cygNIasMEfMJMc13R0zvGEC
	 LCxFJCP/DSxmrkxfZHV3IMaw3FWeXaFiqMdQWrLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfDAX72 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfDAX72 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 1 Apr 2019 19:59:28 -0400
Received: from devnote2 (unknown [147.50.13.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264B9206B6;
        Mon,  1 Apr 2019 23:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554163167;
        bh=YZRcFYhEWBkLgDehzmgeUo0fhIZsW9YwoNRnvs1zKtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zaLsZI0KQFLAnn1IJ9SbEEpM4EsGyvIloN3Uu/nZJ2GERQsE7KqlAT1ys3PFvNbkG
         zsLJ8LWAfnZj+ZhfDkixYndFOXU9CgS7p+iAeYHG1ylIMEf2HZsyEalff1oN2FEA0L
         20oIVn7co7JrXKaFhDJyLk4bsWm4BuZhWoBWwPJ0=
Date:   Tue, 2 Apr 2019 06:59:21 +0700
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v5 00/11] tracing: common error_log for ftrace
Message-Id: <20190402065921.de4831e2bd2f25f6c0587420@kernel.org>
In-Reply-To: <1554125468.8693.4.camel@kernel.org>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
        <20190401091948.0963e7cc4b0116c5d95c4c9c@kernel.org>
        <1554125468.8693.4.camel@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 01 Apr 2019 08:31:08 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> 
> > BTW, could you also add a testcase which tests all (or most of)
> > error cases of hist_err() ?
> > That will be good to find regressions in future changes.
> > 
> 
> I was going to, but there are a lot of error cases and a lot of them
> aren't simple one-liners and require some more involved setup to
> trigger.  I'll submit a follow-on patch to add them as soon as I get
> the chance.

Agreed, I look forward your testcase :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
