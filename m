Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687CB6F2FA
	for <linux-rt-users@vger.kernel.org>; Fri, 23 Aug 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438751; cv=none; b=ce5T0GJU3YLxoE1NRUTXVto6m/GvdQEVUxF8KW1bo8DAX71NXyJgG1hNZc9WfdPCWzDMkfmAHAvnQdVebSOvnzJgiw37k50OB5JYmOzBnp4ocBuMO3K1IxT9raD0sHBVNU81b+/mKUhRDXsZdXV1pe6OI5w/dwycqVqeFIUSGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438751; c=relaxed/simple;
	bh=E7roMvgCtPrLWt67E7RytzzGv17ZLPLswDnIxEfsVWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbCIFr4Xbi+GZqNDUBhxzuTWv2E0SlzLPxM0TqQ3nvdceJKylEXC2nzGokKZ5Fr7n8FLQyc+EQanjM73vGf9h6Ri1Q/gvwSbJHIoe1HDZQJYixr7l/TDKVBsLt7hwL677pK6+YfFzVM91nr0poCNBmIdJE9rrZdxt1bwcvxY8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMwS+oa0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMwS+oa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724438748;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=9An+1E8Iv+yoL+xvG+CcZrCc2W40lzOawPuXEp7JUww=;
	b=bMwS+oa0xgJRE/cx8NCn02hfw51gug8MKDD1ZQSGnhe+RQ3wJgS4+84PQf721EetLwr+Dd
	cyAd8lhD8lMvx1Phhn/+4flPuH4YwoNl0p2nglVmdtBJwo9ldo5ICjhj/TXouamBUG17zf
	i3iUYgErXa4veiEV7vw3fshoVJwT9X8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-t_Idx-VzNq-4R4zy4654aw-1; Fri,
 23 Aug 2024 14:45:44 -0400
X-MC-Unique: t_Idx-VzNq-4R4zy4654aw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D28051955D4A;
	Fri, 23 Aug 2024 18:45:42 +0000 (UTC)
Received: from debarbos-thinkpadt14sgen2i.remote.csb (unknown [10.22.16.64])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1822B19560AA;
	Fri, 23 Aug 2024 18:45:40 +0000 (UTC)
Date: Fri, 23 Aug 2024 14:45:38 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: pmaldek@suse.com, williams@redhat.com, john.ogness@linutronix.de,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: A Comparison of printk between upstream and linux-rt-devel
Message-ID: <ZsjY0puWXKOoq2ed@debarbos-thinkpadt14sgen2i.remote.csb>
Reply-To: debarbos@redhat.com
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
 <20240823070908.D0GYffCS@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823070908.D0GYffCS@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi,

> > For the stock kernel, we observed an average of about 14,263 messages printed
> > within 30 seconds. The standard deviation here hovers at around 1.52 messages,
> > with a variance of 2.3 messages.
> > 
> > For the "new printk" kernel, we observed an average of about 12,693 messages
> > printed within 30 seconds. The standard devation here hovers at about 131.2  
> > messages, with a variance of 17211 messages. 
> > 
> > We observe a rough 12-13 percent overall delta between new printk and the
> > stock kernel in this test case, with a larger disparity in standard
> > deviation/variance.
> 
> I am a bit confused. You write here ~14k messages within 30secs for
> "stock" aka 6.11.0-0.rc3 and then ~12k messages for "new printk" aka
> from the latest RT tree. At the top you write "6.11.0-0.rc3 is slower on
> flush". This means something else I guess.

You are correct.

In the aforementioned test, I am purely measuring the amount of messages that
are printed out to the serial console (and are visible from monitoring said
ttyS0 console) within these parameters:

---- BEGIN test_script.sh ----

echo "Inserted at $(date +%m:%d:%T)" | tee -a /dev/ttyS0 && insmod ./kmod/kthread-noise.ko
sleep 30
echo "Removed at $(date +%m:%d:%T)" | tee - /dev/ttyS0 && rmmod kthread-noise

---- END test_script.sh ----

For the "stock" 6.11.0-0.rc3 kernel, we see 14k messages printed.

For the "new printk" aka Latest RT Tree kernel, we see 12k messages printed.

This measurement is different from the time elapsed from invoking rmmod, and
confirmation from the serial console that the worker test has finished with the
"Finishing worker test" message. I erroneously refered to this as "flushing."

To clarify, Test 3: "Pending Message Speed", is a measurement of total time
elapsed from insertion to confirmation, additionally, there is the quantitative
analysis of how long we take to print pending messages, and print the worker
confirmation message from the invocation of rmmod. 

This is where the stock (aka 6.11.0-0.rc3) kernel is slower, as mentioned in the
TLDR. While we do print around ~12-15% more messages in sheer throughput during
that inital 30 second window, the removal overhead, which comes from printing 
any pending messages, is much higher.

If you'd like, you can try the test and potentially garner a better
understanding of the behavior observed on the serial console. You will notice
that after fully saturating the buffers (which takes approximately 30 seconds),
invoking rmmod does not immediately stop the workers from printing. In the case
of the stock (aka 6.11.0-0.rc3) kernel, the command line will hang, and wait for
the remaining messages to be printed.

> Regarding your RCU stall: You stuff a _lot_ into the printk buffer. And
> then printk is forced print everything out in a single sitting. The
> whole printing job is done within a preempt_disable region so RCU has to
> wait until it is done. If printing of the whole buffer takes >60sec then
> you see your RCU stall.
> The current RT tree will do the printing from a kthread which remains
> preemptible because your printing threads don't print any errors/ panics
> for 30seconds. So RCU gets its turn.
> 
> Sebastian

This makes a lot more sense to me now. I figured I would raise this concern out
of sheer curiosity. Thanks for answering that question!

I hope my ramblings made some sense.

Cheers,

