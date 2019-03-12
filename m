Return-Path: <SRS0=Dbld=RP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171B7C43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBF22087C
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 16:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552409462;
	bh=JqKYz84J3hwKXElgIgyxB9fiRd7g0dLiXoh5PxHm6fU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=CVarOl++vBl6+U6VT8rmG4rkpAZBaWBGnUEjP0qxSlmgd9g6TT375L1dT8d9iOtMk
	 IckfBxX4GGbzHRQGpEGkDo0vf1kNDo/YM1JNnznjbfXtOrJev2pSyY0InhPDQ//xsV
	 E0pTkyAKM+VDQKEn7X+kc8ZgMbjfk4P+ebb49d+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCLQu5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfCLQu5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Mar 2019 12:50:57 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05D102054F;
        Tue, 12 Mar 2019 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552409456;
        bh=JqKYz84J3hwKXElgIgyxB9fiRd7g0dLiXoh5PxHm6fU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lO1M6JYtHIjG3C+PM8TSEXQh+kA/No594nk4Die52cUlK+/4+tuS2YwGOsVAsGVWh
         5fGGTAjEoy0c9NONqQ6w2JhpPxRCEdH2e0GMfMHYbHa0lBv/Xj6kudHjwG7Mqpj22q
         llewtXyvC+Ttc4HHL0aRoMYVJ8g7EnorhaFMaWdU=
Message-ID: <1552409455.4293.24.camel@kernel.org>
Subject: Re: [RFC PATCH v3 3/5] tracing: Use tracing error_log with hist
 triggers
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Tue, 12 Mar 2019 11:50:55 -0500
In-Reply-To: <20190313004631.d8feedaaa0ac701f2322ca38@kernel.org>
References: <cover.1551741458.git.tom.zanussi@linux.intel.com>
         <7cc4a06837b8cbabec0e2b14d96da6396f081dca.1551741458.git.tom.zanussi@linux.intel.com>
         <20190313004631.d8feedaaa0ac701f2322ca38@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Masami,

On Wed, 2019-03-13 at 00:46 +0900, Masami Hiramatsu wrote:
> On Mon,  4 Mar 2019 17:36:46 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Replace hist_err() and hist_err_event() with tracing_log_err() from
> > the new tracing error_log mechanism.
> > 
> > Also add a couple related helper functions and remove most of the
> > old
> > hist_err()-related code.
> > 
> > With this change, users no longer read the hist files for hist
> > trigger
> > error information, but instead look at tracing/error_log for the
> > same
> > information.
> 
> Could you also add a patch which update its testcase?
>  
> test.d/trigger/inter-event/trigger-extended-error-support.tc
> 
> will fail after this patch.
> 

Yeah, good point, will do (and documentation too).

Thanks,

Tom

