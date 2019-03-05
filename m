Return-Path: <SRS0=qrdP=RI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CD8C43381
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Mar 2019 22:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD272075B
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Mar 2019 22:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551823550;
	bh=T77nXYr6+OS4tqm54KfsG/eXkgerVwMwTcOzi7YR088=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=QaedyzMpnIX2kkYONKs4st6sEVdha/s+SuvUXb+y/FR+sbSO8AIew0pQZd9PMHmvI
	 Z4gQ50uPerOJHc8iEVKfmJTAoSHYvRYZLb46ABlmEDELTJao+PmHU1vAx8PjruQUZj
	 QwGdQIZP/Ze3AwsVuKScFc2dYPA84wssjUaVyd8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfCEWFp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfCEWFo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Mar 2019 17:05:44 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF9B1204EC;
        Tue,  5 Mar 2019 22:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551823544;
        bh=T77nXYr6+OS4tqm54KfsG/eXkgerVwMwTcOzi7YR088=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SWsu+ZA4/jmpy+YcH0FEPCjsirPeQOkaMZ/F42LczKshSLav7cCzA2/59SzSTYmAm
         YEkrRQMjxM3Z1ab/UjIFQeCPc3eLXsftLViTiOvwIBRhYZ6azreM+em+z+ega2FJth
         5WczM5S9G5y2aAD53aoH17YVMOk1yIWU7KdcYPjw=
Message-ID: <1551823542.4293.0.camel@kernel.org>
Subject: Re: [RFC PATCH v3 0/5] tracing: common error_log for ftrace
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Tue, 05 Mar 2019 16:05:42 -0600
In-Reply-To: <20190305165846.075a0e6c@gandalf.local.home>
References: <cover.1551741458.git.tom.zanussi@linux.intel.com>
         <20190305165846.075a0e6c@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On Tue, 2019-03-05 at 16:58 -0500, Steven Rostedt wrote:
> On Mon,  4 Mar 2019 17:36:43 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Hi,
> > 
> > This is v3 of the frace error_log RFC patchset, which is the same
> > as
> > the previous version but adds the numbering Masami suggested before
> > each item in the log.  Masami also said he was going to take over
> > the
> > kprobe events patch, but I left it in for now for completeness as
> > it
> > still provides a useful example of possible usage, for evaluation
> > of
> > the overall scheme.  I'll remove it when it's no longer an RFC.
> > 
> > Changes from v2:
> > 
> >   - Added [n] numbering as suggested by Masami
> > 
> > 
> 
> Hi Tom,
> 
> Thanks for doing this!
> 
> Note, I'm marking this as TODO, as the merge window has opened and
> this
> will have to wait till it closes. But that means it may get buried by
> other patches and such marked as TODO. :-p
> 
> Can you send me a friendly reminder in two weeks if you don't hear
> from
> me?
> 

Sure, will do.

Thanks,

Tom

> Thanks!
> 
> -- Steve
