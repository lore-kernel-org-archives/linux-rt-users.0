Return-Path: <SRS0=pHM8=RH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB3C4360F
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 22:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAE320663
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 22:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfCDWWy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:22:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:21877 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfCDWWy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Mar 2019 17:22:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 14:22:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,441,1544515200"; 
   d="scan'208";a="149224348"
Received: from cdbrown-mobl.amr.corp.intel.com ([10.254.61.64])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2019 14:22:53 -0800
Message-ID: <5643a1971831ce2d01a947f0f07cefa002bbdc25.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] tracing: Use strncpy instead of memcpy for string
 keys in hist triggers
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 04 Mar 2019 16:22:52 -0600
In-Reply-To: <20190304165653.17699f9f@gandalf.local.home>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
         <50c35ae1267d64eee975b8125e151e600071d4dc.1549309756.git.tom.zanussi@linux.intel.com>
         <20190304165000.0ce0fbdd@gandalf.local.home>
         <20190304165653.17699f9f@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On Mon, 2019-03-04 at 16:56 -0500, Steven Rostedt wrote:
> On Mon, 4 Mar 2019 16:50:00 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > +++ b/kernel/trace/trace_events_hist.c
> > > @@ -4695,9 +4695,10 @@ static inline void add_to_key(char
> > > *compound_key, void *key,
> > >  		/* ensure NULL-termination */
> > >  		if (size > key_field->size - 1)
> > >  			size = key_field->size - 1;
> > > -	}
> > >  
> > > -	memcpy(compound_key + key_field->offset, key, size);
> > > +		strncpy(compound_key + key_field->offset, (char *)key,
> > > size);
> > > +	} else
> > > +		memcpy(compound_key + key_field->offset, key, size);
> > >  }
> > >    
> > 
> > Shouldn't we use strncpy() in save_comm() too. Feels safer.
> 
> Note, if that is changed, it can be another patch. This one is fine
> as
> is. I just was looking at other use cases of memcpy() in that file.
> 

Hmm, I don't think it's really necessary - it's not used in a key so
don't care about anything after the null, and TASK_COMM_LEN is used in
the memcpy.

Tom

> -- Steve

