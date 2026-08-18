Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2022AE7A
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2026 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094967; cv=none; b=nUCeiwYxFptjOTG2dlMxxVN2KKk9oJPnmfmLNgjuZmCiGwd8yPRloibUOn5n7Th8t4Vrszsv70mgFiRxLtlnWgiWyQuHNh0sVkgpqbqKQBwHORt6b2zwl4oL69YWdUXr+MNsUJP/ybTdMt6Oa3KAwj6UVKWPx+NkqqlO4HXi73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094967; c=relaxed/simple;
	bh=hfOmlYUJ1Xg6K2uADrH9tewW5pr2uYYhxPZq0othhT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqjS6Ln99sa+bDocSKWsY4l1Mdt16hOrJAI+C0LHtq/7b+PCR8uUXR5VBjletUo+C5YcWszsffUrdrLcPZYaolgN9GWV+G6aB2fARtWExDmq3ckham5pLhijHxe/kidu5zERdsH7OZ6b1aQZ/G0NJWkSg2q1e64s3wiBeEsi0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE45zYFt; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE45zYFt"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-936dfd009d1so123290785a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2026 16:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787094965; x=1787699765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uX6nr0JIzcLE+NcVJ27kUF2rAzFYy7RAX55+HUnzOQo=;
        b=VE45zYFt/WQGqXLJnX3jKRgox/MHfx1NvmM6dAeiXuqBX4i+qTCnhq1vg6grHaEqvD
         dCgPM7utxgvNdc1+/e0MKwNGmPV0dOfj0PL/M8jJFTacRQBDjb08kmRd8TBDrItbNlBf
         Nzxd8HTAIUqNkVnTIIYNR8SEXRCicKtzaMDV/Fw8KXySoV3x9NAtlZp9NVyGG1s+t4Ii
         InzpKGc+3lvrwzxR3geKpDZsRxHWPZVgCATW3eB81CRGLHO7Qa/0in+HFhVcKDVsowrH
         mRqYqWAMTsPEytQjBPlcdXM8Wq34R90g7VF8MOs5WjTp2oYLsFa5q1q74bXQpcI3sCNS
         TkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787094965; x=1787699765;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uX6nr0JIzcLE+NcVJ27kUF2rAzFYy7RAX55+HUnzOQo=;
        b=j871mGTqng8JiJsfZXF1f8/mSWjHAeFxyANLM8Yk9zLCdhFoGJDajZQ/lwDtKZf14e
         YWdv5lhFpwGipGyohtd3Lg589ACSqZcqipQmj6z0vntm9xf05NP6ifZOzl4e34/mvY5n
         bHInV5udTWaYChEdBizlkgb8DYInKSPXk6OQ6AngbHGJM1POpaSI8nkEJW58EsvmeDgn
         13QHiKOzc82v5r/N2R5Nldg9RgkFCPx8EsvYe2cg63Yqzl02gz6mPOxeUMuSnFbHClZF
         4X4fbWEKVkuuUA4ZGmhgVX7LLBAOlDsDWSwo40KT70DwrBOEhsfPbCQvdnbtDzKxPoYh
         Wy8g==
X-Gm-Message-State: AOJu0YxdrRDlY3REivB/+8WPlZn52gzaKh3s/ns2bTqKwUVcA+O+R9/Y
	OZkm/PsD3PW2I/Coa567aJW1lnKGI5wFz+1HKycYj6/hiIDRpCmWo8MX
X-Gm-Gg: AR+sD114dZJdWIx1r85q+geDBQs8qn4WNkKEBv41F39tusz+UJDVm1FNQXUmzAnjWg3
	QJlKqafqlsBn+VDbFS7CDdafhL2Hbz3Kb+14H2zHRiXUcrQf1P2VgcW8LGQjSo+TEjZ9eDj5tKj
	1E/lAA3lsoIem6Q20ablnWpwz5t7/qNF9lh9jg4/QjJ2apv79vvIL4QWMliJa0yyTGarJbPPiCs
	38VO0o0ZKuNGRvKdNLfWdSLzuiIoExgz1bdO+/xGakKmragDY1OOw4Q/83ayWUpMSX1xNSPx7y2
	TsPXpr01+ioxi35biXXo6+IHBLg3+aUPfwDw5kBP5LgoDW9U9ZfH4Uk5Cq2HAy6UEXPX9kJPojJ
	qx70WXDIZAJxPE4Lp+bDG1WiemUVtzPXjadiYiwAV4apXglw+5Ixl7RIDDnkzCF1X5daiBhSaAn
	xXxemNRNmKmtoOg3GuXP5rkxhnqpGBv2lHS/m802hlWn+76WCDt4CN+GzDn0Pf4+Rv+DhBlRjh2
	r0MQuMxETTm8kVWdX/6WaXWkAeuc/EGjmd1JeqWvl1dU0FHYLHrMgg=
X-Received: by 2002:a05:620a:6ccb:b0:915:5216:e5bf with SMTP id af79cd13be357-9371e74b030mr84474985a.22.1787094965291;
        Tue, 18 Aug 2026 16:16:05 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720493eeasm8110685a.3.2026.08.18.16.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:16:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] Adding stressor validation for stress-ng
Date: Tue, 18 Aug 2026 19:15:49 -0400
Message-ID: <20260818231549.224764-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818175923.315976-1-sansshar@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sana,

Thanks for the patch! The validation logic looks good and the error messages are helpful.

One request: could you move `get_valid_stressors()` and `validate_stressor()`
out of the class and make them module-level functions? They don't need access to
the class instance, and module-level functions are easier to unit test and can be
imported directly.

Place them after the imports and before the class definition:

def get_valid_stressors():
    """Query stress-ng for list of valid stressor names."""
    try:
        result = subprocess.run(['stress-ng', '--stressors'],
                              capture_output=True, text=True, check=True)
        return result.stdout.strip().split()
    except (subprocess.CalledProcessError, FileNotFoundError):
        return []

def validate_stressor(stressor_name):
    """Validate a single stressor name against stress-ng's available stressors."""
    valid = get_valid_stressors()
    if not valid:
        return

    if stressor_name not in valid:
        raise ValueError(f"Invalid stress-ng stressor: '{stressor_name}'. "
                        f"Run 'stress-ng --stressors' to see valid options.")

Then call it in _WorkloadPrepare() as: validate_stressor(self.cfg.stressor)

Thanks!
John
