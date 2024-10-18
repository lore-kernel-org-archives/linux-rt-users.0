Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B543B192
	for <linux-rt-users@vger.kernel.org>; Fri, 18 Oct 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214923; cv=none; b=TeNUs8CYAIyqIpVBJpXGjhbKHc8dX25CeHg4cEdARVBsGAsbdA28/d1czlDS17U+fojZI7kP5QTANaVXDQnSzE46EbIjzp6AGeqEN+EO+QzUX5L91diTqDE02N3QKJxSpdaSWJy0uxrT2wt839lyZ21ex4Tf11msc1FII9isHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214923; c=relaxed/simple;
	bh=24HSTMQxrQfTnRtaD1A+QoDa7nLmq2qmwjjr7DfFD3I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E9isP8bxtmXDgkUnOhpRmeIO/VZeHBfG28l4yxMNmqsDcBnune3knLLYIWWgYiJWoajZdsj10gpga1z9m6qGntvsD80PcEEcaqsGp2oLj7Y9277huD7dbaCoQnfdRKamh134eFTdkVeGyuWS7hNMK3qjl22R4jDYj/KXex3Oe9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cf5O7VKe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cf5O7VKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729214920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4nL99vyDBpwDt+YMZ5mnEJWRwrImbAbca9RaGrUrQY=;
	b=cf5O7VKeh+jwlm/HjRDM6PKdkMlge7Rw2JjRf75MGnMGoTY09ewarxY+oubdO+poJqDPRw
	BSEHqWb9YzZa/Mte7AdXD41Fs7zleOwnjn9I37JGS9TqK8sEmGmlfn7qlhcJdgEFz8k7Yz
	AJ6deDVHlUncaJSFWm/07M9w+9TozRQ=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-Iqc2LxwEMB69rdJ9346UAA-1; Thu, 17 Oct 2024 21:28:39 -0400
X-MC-Unique: Iqc2LxwEMB69rdJ9346UAA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso16268095ab.0
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Oct 2024 18:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729214918; x=1729819718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4nL99vyDBpwDt+YMZ5mnEJWRwrImbAbca9RaGrUrQY=;
        b=WVs3vEBt8OcXNkrfPsoMpQ1KKWKAiU3mKBynISvXko5Iaep/WKQ4rFPqMJIWVa1nmP
         U8kkdiW1xT8GQLx5bBwla9oRTMI/4sXpJK33r5paIGmNRbEegO2NjfcSNJWYnBRnp0lQ
         zayzOF4F15pnlchpGfstnRwW6KxdOKraCjHUPo/xSVg+QaMegD8LGWPksbzeRMCCxTT7
         Ig9eT0zWaPz88Wkh1P4OKB6xnW0MB0h1QiVLE0XdUSkfdeSlfKB5gvabqsRmzVbFTDng
         kho9gp/BWUALk7PBUf4M7AqtmYCv/Md6YBL1lKBt5FHN/Pjd2+2fIZqBetSX1Kd9cb0i
         aLdQ==
X-Gm-Message-State: AOJu0YwXfzB6AG283vRfIEYWBcidBFLNkao99QHQ4rMm4u6A8WOP6lHw
	ZPp8dhcLEr1ukFcmfW4wlNqseMlDJVmwynDx+KpqqD1hsfXEFW+U+h7MQ2qgevhgvf6PsB2ltfy
	xRh/08OYo9hGIYZovl6uNzP3m6aIQ9pS7DabarR5KgAF7O9azgRHctXAQNeUBxXzSBiRLR6k9+L
	Jx4A==
X-Received: by 2002:a92:cda3:0:b0:3a1:a243:c7a7 with SMTP id e9e14a558f8ab-3a3f404ffb5mr8595455ab.2.1729214918244;
        Thu, 17 Oct 2024 18:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnCLg5dvsyRvNWXNg2UXyN2mEMmZeaT4SFddarrr6ZrtgAgqCMu8+Lw6762VxyP5EhVndKSw==
X-Received: by 2002:a92:cda3:0:b0:3a1:a243:c7a7 with SMTP id e9e14a558f8ab-3a3f404ffb5mr8595345ab.2.1729214917969;
        Thu, 17 Oct 2024 18:28:37 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3f3fd812esm1288975ab.7.2024.10.17.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 18:28:37 -0700 (PDT)
Message-ID: <06da12f70419f50ec31d3a04b9d570198f829e2b.camel@redhat.com>
Subject: Re: kernel module and priority or affinity
From: Crystal Wood <crwood@redhat.com>
To: Le Chaudron Nautique <vanvan@chaudron-nautique.fr>, Alison Chaiken
	 <achaiken@aurora.tech>
Cc: linux-rt-users@vger.kernel.org
Date: Thu, 17 Oct 2024 20:28:36 -0500
In-Reply-To: <315b21ba-e53f-4f3d-9739-25547821feba@chaudron-nautique.fr>
References: <f2da9d69-09a6-4086-953b-a24f355f0033@chaudron-nautique.fr>
	 <CAFzL-7vvEjkyyD4NfJWqeqxmsgq05ZMh2Bx6cPqitEsM3WpkCg@mail.gmail.com>
	 <315b21ba-e53f-4f3d-9739-25547821feba@chaudron-nautique.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-10-13 at 12:14 +0200, Le Chaudron Nautique wrote:
> Thanks a lot.
>=20
> I think the chrt command is the one I was missing.
>=20
> I will try to set this up on a raspberry Pi 4b, with the current 6.12
> kernel, and maybe later move it to a more robust device if necessary.
>=20
> The major difficulty I have in my understanding, is sometimes the limit
> between userspace and kernel :
>=20
> I would believe pthread is for userspace and kthread for kernel ? And
> the management of pthread would be done by sched fonctions, that of=20
> kthread with chrt ?

chrt is just a command-line tool that calls the sched functions.  The
type of thread doesn't matter.
=20
> And kthreads are seen as "tasks" with ps where pthread won't be seen,
> only the main process ?

Only because there's no kernel "process" to group them under.  You can
see all threads in ps with the H option.

> As for the interrupts priorities, the top-half will be 50, but I would
> still be able to use a different priority for the bottom half if I use
> threaded irqs ?

Bottom halves aren't individual threads, so you can't set that kind of
priority.  The bottom half should typically run in the IRQ thread that
raised it, though it could also run in ksoftirqd.  If you're writing
this driver, it's better to avoid bottom halves entirely, and use other
mechanisms such as workqueues or kthreads to defer work.

-Crystal

