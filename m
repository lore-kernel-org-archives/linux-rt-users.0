Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F218FC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Dec 2021 12:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhLNM0U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Dec 2021 07:26:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231744AbhLNM0U (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Dec 2021 07:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639484779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNWLhg1ntWwp5Ppu09h0Eh4UGAn0KphaoLRSOYk8nM8=;
        b=UW3qsvsE+CkfW50igxM3rIOGipSPWaLBVR/RuttDTJ4XcSM67itm/HLbzgtbXhC3o3BNzf
        S6NAyQVEUSxCmCMARZveTDCXGTjF1A0BJhl2I6HXbdhBTL/Pwqc7Bc/ZMEIbkGalz29tyV
        sjdrbDSVkEaRAQnu4LOWF8KtDvyevPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-BMYZV-O3O2KuLxy71sdZRg-1; Tue, 14 Dec 2021 07:26:18 -0500
X-MC-Unique: BMYZV-O3O2KuLxy71sdZRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63D3B192CC40;
        Tue, 14 Dec 2021 12:26:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38EEE5E26D;
        Tue, 14 Dec 2021 12:26:01 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 506EA416D862; Tue, 14 Dec 2021 09:25:58 -0300 (-03)
Date:   Tue, 14 Dec 2021 09:25:58 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.org>
Cc:     Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@gentwo.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org, nilal@redhat.com,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, ppandit@redhat.com
Subject: Re: [PATCH v2 3/3] mm/page_alloc: Remotely drain per-cpu lists
Message-ID: <20211214122558.GB57271@fuller.cnet>
References: <20211103170512.2745765-1-nsaenzju@redhat.com>
 <20211103170512.2745765-4-nsaenzju@redhat.com>
 <20211203141306.GG3301@suse.de>
 <20211209174535.GA70283@fuller.cnet>
 <20211210105549.GJ3301@suse.de>
 <20211214105823.GA53878@fuller.cnet>
 <alpine.DEB.2.22.394.2112141239550.371576@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2112141239550.371576@gentwo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Dec 14, 2021 at 12:42:58PM +0100, Christoph Lameter wrote:
> On Tue, 14 Dec 2021, Marcelo Tosatti wrote:
> 
> > > downside is that there will be a performance penalty if an application
> > > running on a NOHZ_FULL CPU is page allocator intensive for whatever
> > > reason.  However, I guess this is unlikely because if there was a lot
> > > of kernel activity for a NOHZ_FULL CPU, the vmstat shepherd would also
> > > cause interference.
> >
> > Yes, it does, and its being fixed:
> >
> > https://lkml.org/lkml/2021/12/8/663
> >
> > Honestly i am not sure whether the association between a nohz_full CPU
> > and "should be mostly in userspace" is desired. The RCU solution
> > would be more generic. As Nicolas mentioned, for the usecases in
> > questions, either solution is OK.
> >
> > Thomas, Frederic, Christoph, do you have any opinion on this ?
> 
> Applications running would ideally have no performance penalty and there
> is no  issue with kernel activity unless the application is in its special
> low latency loop. NOHZ is currently only activated after spinning in that
> loop for 2 seconds or so. Would be best to be able to trigger that
> manually somehow.

Can add a task isolation feature to do that.

> And I would prefer to be able to run the whole system as
> NOHZ and have the ability to selectively enable the quiet mode if a
> process requires it for its processing.

IIRC Frederic has been working on that.

Thanks.

