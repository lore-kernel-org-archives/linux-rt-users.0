Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C022C11D2F
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A4720828
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582558494;
	bh=MNQ1UVYC0Mn/mwU5T91zK1An5TUeYxUPkvlyAHEUoHQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=wlmHCnTpMrBxW6O9X7UOiFZH9LmpBaDXI2bCffqybFbC20YuHFJswt+a41sTjMvA0
	 9UwYN/uh4BrNjEnpOBGHY6rAn0FNETZEmsvOsp/1wDBKzYNXNaQUkll7/K9xFk0QkJ
	 oCmeOjCJj/9DF+1gJGdZJI9fAH4xwAelWOOnsVQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgBXPex (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:34:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbgBXPex (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 10:34:53 -0500
Received: from tzanussi-mobl7 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 382C620714;
        Mon, 24 Feb 2020 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582558492;
        bh=MNQ1UVYC0Mn/mwU5T91zK1An5TUeYxUPkvlyAHEUoHQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DoaFobJmGFl441Ocv2uQKWc+qbEjG1zTcPi+8jqa2ogNge036u3te0ReU+g3Zunsm
         nwVMUp8PplERgkQOZExShC3gg/Gog5C2Uw9RdkYlv2j2VWH5iagZb2WSs9/bzb5DH5
         OKEaCsHDokmCNw0gayR99PJ9OblSNqtpZeLtL+NQ=
Message-ID: <1582558491.12738.36.camel@kernel.org>
Subject: Re: [PATCH RT 21/25] smp: Use smp_cond_func_t as type for the
 conditional function
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Date:   Mon, 24 Feb 2020 09:34:51 -0600
In-Reply-To: <20200224095227.kfzl2lhonpmderlj@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
         <c7bd8ba713f3e67bf77ea6847ab85ab47f8168a2.1582320278.git.zanussi@kernel.org>
         <20200224095227.kfzl2lhonpmderlj@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-02-24 at 10:52 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-02-21 15:24:49 [-0600], zanussi@kernel.org wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > v4.14.170-rt75-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> 
> This alone makes no sense. I had this in the devel tree as part of a
> three patch series to remove a limitation in on_each_cpu_cond_mask().
> This does not apply to the v4.14 series due to lack of the
> on_each_cpu_cond_mask() function.
> 

Yeah, I did drop the on_each_cpu_cond_mask() versions, but the typedef
itself seemed like a nice innocuous cleanup.  Will drop though as it's
really unnecessary.

Thanks,

Tom

> Sebastian
