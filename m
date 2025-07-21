Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3B23A98E
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130067; cv=none; b=pslgRWxtdS7b4JrQvCOBWisEE/chZabdROwVQWoFhrMJEWaG9oj1cZI4cbiGMknHC1yP5SPm+kZzxKL5lhIibCRB+K1kUUrtQDDQAR7vSpv0I6dTGOnE6vkeQ0YSnSSwEuD79eP9np2kpZPokAkPSmySdg/egGBf2kg4cmh3xfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130067; c=relaxed/simple;
	bh=LPFzmeAXx/r/kjKsJ58qmamKdNrurWALXVMiP9PbB7A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UCHLiaEGqiWNT+BEK/1MZ4Hxw+aVQ/DxfshVSg4FS3N0hmPqGvUydCQDeIT6QvKXeqKfAdKoxQgGu3c51dGZ05LmArbS3UUyZVUwByzr1Q3CumUXueQqnIfBIYdtaCXnQJKE+hjBIhLj/+DNKhMk+X3urEYV+03Hb+uYvkOnF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UodHLRbu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UodHLRbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753130065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+kZFjscj+kS4mqfk7fqCAxuWU3kN43qP+nq52ggAOQ=;
	b=UodHLRbuoGrpopRrBaWSSUn9HiJrLuD10LAjNG+wvaSwJyvMoHi3aKVBh6bSL/9FdS0BGI
	cGMzQ8MpUngGuoIUgo0OL20h+U25PDeY8p9Yv6HiYoWBQQYDzRRpO6pNZueme5ISfhvlsg
	nXNlEXTDofo9tr5rzT7IJf/0BfFd4f0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-ySLbYQEAMsunLo-56IDLtg-1; Mon, 21 Jul 2025 16:34:24 -0400
X-MC-Unique: ySLbYQEAMsunLo-56IDLtg-1
X-Mimecast-MFC-AGG-ID: ySLbYQEAMsunLo-56IDLtg_1753130063
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e190b977b9so709690085a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130063; x=1753734863;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+kZFjscj+kS4mqfk7fqCAxuWU3kN43qP+nq52ggAOQ=;
        b=GgNKevI1p5q1GWwqfcy04FVXkp5pOv+8l0QzqRvJT+yRt3sH8WUf1SMgTHArpwBcVA
         TnPHC7QqGugEJQZBV0iwrei+WhzT0CZzgW2JKhztSKz/kcrxjMTPcjFS4ARHom+rtw5b
         wFlVq2txl+s+gB8QYPa7VE+8zKW4l+s9nxN5sp35yX9DgJb/5Yx/V9GIpUFzrsmP1c4g
         syzTK5T0V36pqGMBGxnEhkJfguZSeIYBJx7npqV99Tu9GESe/RtSupQEg7p0BjGMrioF
         858ha3kmWe53/c/AOPL6fDhJjY7ArBRMluoQeyssnjGhowMtNX7hu4yM+UiKQU80SyE4
         ZvmA==
X-Gm-Message-State: AOJu0Yze/FE/V8MOxF4348BOZCQy249V96Vpru3qtvO9nrBBBt9YW3vX
	cMIPUbFsFbuauHnO8PAdjUJYkbByw8HWSsqMGx381i4jfQa+LfPQq1EKsXihB5w+nydh/gEE5U2
	ynZdtSub0VRnaZZt12PvixyMjBzsIoaxlY1SSW1RHsmSSYyqAu7bVWP0lWTbGWrtTrFRIuB4PM5
	yl
X-Gm-Gg: ASbGncvIs0fcAnuhiRcMkaL0ixFgxkT6Qscwe0404+nDK4jGuiWwV79zKGd2sGqBqyL
	i0dLHrx1ciWk2FRlAkvJl92tIDcDvUYLJH0jvd4ir67pQAz9FU0vxrU5oVLcZA+TMCSnOO538it
	rn6xAUjl2Y+jg5/S/BugW2cXnj2KCkhADwQmYtBJdIPA3gLMWESfbCVt+2PXwbL3vQGs43OrCoU
	QERsDjGz6B6m2COm82BBYZJUR5SShAHcZ4PxMBzpFooZ0HMw1ABOvNvcR5yzmItIQ5RCpKJ0YYb
	oyNkTXuBMxbq/g9Hcs4UovCAdH86AA==
X-Received: by 2002:a05:620a:4006:b0:7e3:4428:541c with SMTP id af79cd13be357-7e62123626emr137927085a.30.1753130062722;
        Mon, 21 Jul 2025 13:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOfGGtYfXAxD7ufpSezJRrj98xnT6M3J2XPCkUYRl6SMGYgqfKDCVrenLC+ZuRgWxGQsq8jA==
X-Received: by 2002:a05:620a:4006:b0:7e3:4428:541c with SMTP id af79cd13be357-7e62123626emr137924885a.30.1753130062354;
        Mon, 21 Jul 2025 13:34:22 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c64171sm464246185a.77.2025.07.21.13.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:34:21 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:34:21 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 02/28] cyclictest.8: Synopsis: Remove -U
In-Reply-To: <aH58BNMiXZj8rqFh@lx-t490>
Message-ID: <ed3638c7-29c3-159f-5e6b-2ea1e8148b50@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-3-darwi@linutronix.de> <08edd7fc-a9d4-87cc-9c3e-7aa135c8d15a@redhat.com> <aH58BNMiXZj8rqFh@lx-t490>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 21 Jul 2025, Ahmed S. Darwish wrote:

> On Mon, 21 Jul 2025, John Kacur wrote:
> >
> > On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:
> >
> > > Commit 7ea837b01d7e ("rt-tests: cyclictest: Remove numa from help")
> > > removed --numa from the manpage but forgot to remove its shorthand, -U.
> > >
> > > Remove it.
> ...
> > > -[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ] [ \-S | \-U ]"
> > > +[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ]"
> >
> > But don't remove -S
> >
> 
> Correct; will do.
> 
> Thanks,
> Ahmed
> 
> 
I a branch called manpage
Rather than having to respin every patch, I signed off on the above, so 
send a follow-up patch to correct the above please

John Kacur

