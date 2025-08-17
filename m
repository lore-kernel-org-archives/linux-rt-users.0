Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B02DC33A
	for <linux-rt-users@vger.kernel.org>; Sun, 17 Aug 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755440839; cv=none; b=TkUnUiuW+aqfVKsrLY7Q8CapMHmQK/BxAOartoS1Zf3lif+HkQJYP+18GYdZ4dQxavxDGI+DU8hfBuGybX1u0U8s+4s74sIyIVpuiv2AlAehMDi8F2Otqk2DqNWfRzIWfSQFdiDlxsoca7McrK2emEzxI+j4sD4A2Fd4uB+qulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755440839; c=relaxed/simple;
	bh=lDpq8I98j7ygHtJNnQA9whbnrtcvMAxLIsDOkN+5U5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LElf9ZS+ZZl+eoMOWSn+Jvsb8RwDDlrD/CsVTqY+fuipyZi8wlPsuxUW843KUT+JQyC6qCEWPirlccrKLr+xjZ07BuRmiK+hanFm6xqWHHKBMS+psyaESYg4pdbMx1mg/3FdJEXg+vd4+7Q/QLL2WnxdFaJAlS61aqD4PCSPsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=WOddVjmw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="WOddVjmw"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109bd3f9fso44619531cf.2
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Aug 2025 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755440835; x=1756045635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=maDtJ/OnwRzl2mzIghqGwSPF8ovKhpPVT9edc4eCiH8=;
        b=WOddVjmwX1cayKg/mSl88CsPX8QnfbVX4kuBoisupimerSVu6XvtpA8bg90gE4R/QW
         M+1d89Gkhhwi75mL6bOhMtvOGIVy9ttl4pdtr3p7NL6+Km1Vz7NnEtksa124k/kPCZQg
         szKZywRJcN64r8BJnxHVK1v6WDq7U7mkj8l8WU5jKKszOzjZFaGnvRJxLe8S0l+Q0v+H
         Te0VRODB+dINAY0TNRRDYW0HLIam68oPG1VMfqwLBc7eHM2W62wXRQ5zn847phdSxkaU
         gvTdGnaN5DzuKsVgqk2qNwjEOfRwM+IJI931iVUWQLZfR6uiDm06irgg0wfuw+isyuQH
         vCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755440835; x=1756045635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maDtJ/OnwRzl2mzIghqGwSPF8ovKhpPVT9edc4eCiH8=;
        b=IM4cgFsYyYi+eRIC0IUVrrHdaX8V/SUlaa0cIMx6qHbvedCLXsjqalctj1XxHd3+D/
         hv477+NSPJUxZC8ymuSgdOon2Fu1bCQNhMq90M0L5Imaq28KC8Z25hw2vjg7vuWXbJgB
         be3b4y15rIU/GI8dZkVzoL98IgpoHH8FJN6XRK3sZrHpE+9cVC8mEF0kOGcPvCKZRuZs
         dPLNoqxQ0uOQd5l2DwiKpKXS/G0/hvSPUaxtay9PP/T1DIYYBDVRFEJfmM+x4NDL6xha
         cBgJyY9FTQan4wXI2+mMuAVVkZCAwToICuzOSif+kSaXoU4UOXbDsCg4WZefilTexsek
         c+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXexP3nPU726C+9XvkeQiMAOpmwNWid4dYmn2ny8U+xIY3wtP3T5j0tHZn1R2GOSkk4t62kLsv6BbxRosdD1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2B6aP9tvfY6NbUpzjRXi7Q9Z6wg87RIlYIkuS9EAWaTfBihtD
	njmbiRYA+vYe1+ZiriFzNephUx17IclpmS+1YufRcjFH2237xSP1t5BbVvPnIEL0F0Th+vXTaTl
	Y1JY=
X-Gm-Gg: ASbGncvqxBZwwl8xniElyJx7vzyGjXaIUMD3pDwHV99siXU3rRNJ1oPO8n5WByIemlJ
	BOnRqUxGmTZX1GgKgAaxwe4K/aqhkONfIr9HSGzFLA7xyYokFdIHD8JbCua9f8ASIF6NZ/4pSQ5
	EB9exWPLcKY33YcdJdAIS8K4BxBsUQY7XWw9QA1qeN/rrMfUBKck2EXUlbJREytxYLnsZ1Srhp2
	W08ERe64CTVF7x+ifWstUeGcg57cTNIi4YXPjjAemqh4uCWXgCFa4/yGR4lb2+zBtj3CyTPs1JZ
	oY72FrrYFyxMcYljiUrd7AJInNcqAqb6/I0FH6vIJS7vDnknt4+iXjZZPwBv64cx6seNYamX8ER
	uKNxjYjeggciGF0zCHPIJyFNao1zKKtDXBwCY1A==
X-Google-Smtp-Source: AGHT+IE7mcvpDwN6PKRambQsOmtvuGU5trnDeiipWqjRmMVW9O5h9Q9S2jd9sA9uj5EzwPmhQmqFRQ==
X-Received: by 2002:a05:622a:4c17:b0:4b0:710d:3cbd with SMTP id d75a77b69052e-4b11e060063mr103987241cf.7.1755440835014;
        Sun, 17 Aug 2025 07:27:15 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::f777])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd8727sm37627401cf.39.2025.08.17.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 07:27:14 -0700 (PDT)
Date: Sun, 17 Aug 2025 10:27:11 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: [BUG] usbip: vhci: Sleeping function called from invalid context
 in vhci_urb_enqueue on PREEMPT_RT
Message-ID: <2bf33071-e05e-4b89-b149-30b90888606f@rowland.harvard.edu>
References: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
 <f6cdf21a-642f-458c-85c1-0c2e1526f539@rowland.harvard.edu>
 <28544110-3021-43da-b32e-9785c81a42c1@kzalloc.com>
 <1088432b-b433-4bab-a927-69e55d9eb433@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088432b-b433-4bab-a927-69e55d9eb433@rowland.harvard.edu>

On Sat, Aug 16, 2025 at 10:16:34AM -0400, Alan Stern wrote:
> So it looks like we should be using a different function instead of 
> local_irq_disable().  We need something which in a non-RT build will 
> disable interrupts on the local CPU, but in an RT build will merely 
> disable preemption.  (In fact, every occurrence of local_irq_disable() 
> in the USB subsystem probably should be changed in this way.)

Or maybe what we need is something that in a non-RT build will disable 
local interrupts and in an RT build will do nothing.  (I suspect that RT 
kernels won't like it if we call spin_lock() while preemption is 
disabled.)

> Is there such a function?

Alan Stern
