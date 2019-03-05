Return-Path: <SRS0=qrdP=RI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C87C43381
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Mar 2019 00:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4173A2070B
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Mar 2019 00:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551744155;
	bh=Ux8/YbJjP9yh30Q8QH+q7zD0Qdj3rgun+Bf6UGmdC+U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=JW1wWydcY4b7C3k3HDdNOsCEgSbrpHUkRlC66dhCX2PaCSh2lw0LeAT2CE94kow2a
	 7R4P+jaamer/gxfW1MkscucPHltBD1xCR9HDgPWcDNu0ONkDcCiDxovEPzHgslHgXR
	 aeUvXUTiq3mrnMT+ZmEAo5/MsR1GRMyi0nftzTEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfCEACa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:02:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfCEAC3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Mar 2019 19:02:29 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A994E206B8;
        Tue,  5 Mar 2019 00:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551744149;
        bh=Ux8/YbJjP9yh30Q8QH+q7zD0Qdj3rgun+Bf6UGmdC+U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FQtzdd+mnLuMe3A/bTRJFCG+rIo2z0HbPd/PWsHPeICKRjVjtK3xwJkgwhvgagOhu
         jLxiVxd7ZfmyW5G7GrtggWtZ+90SN3nIXVcudFCjZwt3fz06rntU4VTTo8bfh3BXq4
         f11YYUhb6h8piFeX6LM9wxnkAfESNu51W9/VWHtQ=
Message-ID: <1551744147.3771.0.camel@kernel.org>
Subject: Re: [PATCH 2/2] tracing: Use strncpy instead of memcpy for string
 keys in hist triggers
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 04 Mar 2019 18:02:27 -0600
In-Reply-To: <20190304184530.7e819698@gandalf.local.home>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
         <50c35ae1267d64eee975b8125e151e600071d4dc.1549309756.git.tom.zanussi@linux.intel.com>
         <20190304165000.0ce0fbdd@gandalf.local.home>
         <20190304165653.17699f9f@gandalf.local.home>
         <5643a1971831ce2d01a947f0f07cefa002bbdc25.camel@linux.intel.com>
         <5c978b4b0d629e5a914c512c14f99f6a24241407.camel@linux.intel.com>
         <20190304184530.7e819698@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2019-03-04 at 18:45 -0500, Steven Rostedt wrote:
> On Mon, 04 Mar 2019 16:31:40 -0600
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > > Hmm, I don't think it's really necessary - it's not used in a key
> > > so
> > > don't care about anything after the null, and TASK_COMM_LEN is
> > > used
> > > in
> > > the memcpy.  
> > 
> > Never mind, yeah, it would make sense to do this, will create
> > another
> > patch...
> 
> And probably should change the memcpy() of comm in
> kernel/trace/trace.c
> too. It could be that memcpy() is a little bit faster than strncpy(),
> and this is done on scheduling switches when tracing is active, but
> still, I'm starting to think that isn't a good choice.
> 

OK, will add that too.

Tom


> -- Steve
