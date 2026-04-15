Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53243859F4
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776281277; cv=none; b=ROY6uELUv+aRkJl2K8DSyzg/6sGovTrFlorsWL+XASnuoFrlLJ/CoCmm4biiXIBnO4jK/oCOkRamYG+CwZh68BJWPs6Q05Zz35EyK9QZzexnIfJavDg8IhsqnWJs0JOK9cbPisNMyqPH8OZm0o5ypkv9XomwzohrRqFrqxV/Ais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776281277; c=relaxed/simple;
	bh=elJk2c4W6wJAHlYvUx3U6UPuPrO5Y0WVj4VOekg4gfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhSyiWv2noZORoU28CxHaCShYycj5F/HZ3UTi1z7GiBJOMClPakiiw3MuAgD1XlEca6eFqXv5fmVI2YjGstVPURTnGAyOHheO+GqGlou7PtNUcCp8tPy6Bt+Wvl/QlElPsckL/cluqzGbNMvOtrMZcy7RezlsZvmx/eq8G5OTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG2zf2MO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG2zf2MO"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3bae8d3eso631112785a.1
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776281276; x=1776886076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5yUYtHDpN4JyGaiDu88WU/SmHGWK5TduzZdBvvpMjs=;
        b=VG2zf2MOrPLfvWFyb89MGLCFSiR8cPdj7eidRaUP1YRpfGkhSXruO29PCRo7LBbyyC
         5vSCJz5Y34eqTbHP4WcA9JxjMD6ZWNmldo6LAQr//vHjmjxraPWgU88KR5gWvtZmFo7a
         ocFb5+xggs05T7HuJ0HpZ72b/yzujjZXolPWSlDf3QYdzsHP3uPx7zWNKcQgtQVjS9XY
         0UZ7Zte+JD6/Ep5YIfPSYXQhIbGL4zpJqmyIdbu0EJ4rwc3zWbCYL7xdHdTqfrRX+jaA
         N5B2kJjCKbVa4zfj3sSOs2Qn3h+ZgsTkhGhEqWq7fFy0ddlBFhETVxt23a9vZ7WbxuKS
         w3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776281276; x=1776886076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5yUYtHDpN4JyGaiDu88WU/SmHGWK5TduzZdBvvpMjs=;
        b=i1423eQjuox+ntDujbwZOj3gKiZFG/90egf/ebjW+GFzDtsKDeSulkUwgqbYWVsHrh
         MXUVhJVCRBae1CAM0MvckPc2iHUopoPb8XsvRXioMujO7f2Sxq68AJRB4aPLtCf+uP/7
         Zuwmwt81wsgnRZ5zT3Md4tOdX9b4ZPAp4+fXKfYP3sP6ooxW3SQxC0Y02Vr0ftKrDiQP
         Q3M3Yr4VQdMEDbUorkfn9RzeGhznVzW8mAFA03h1zKWpvnxcuFxNyqr3SHCdiAOcSylL
         owjp8OGtOvJHaHZv8ua8dosiL/T2Xdp9Uv+WKC/6hNqAE7U5EzeY6m5kYHZ35AHJjOoB
         t2cA==
X-Gm-Message-State: AOJu0Yw1nzmcwfMCpOivxZ+I4CoFGh6Q85pvH78Gp+992XZycsKukwes
	oV2x95ajoeRnwEybElLOKcfWboM0m0l6GBWmxk06c2xZk/8ztVJucjRNjOPjqw==
X-Gm-Gg: AeBDievv82Z4WqvHkrT/ojfAFcPQQHaovEvisauvLYM1jI8fkC0H25MhLPS8nVx88b5
	l4B5IPSy9SvAGbK9JD2zv0W1GbviP/5IRhWjMS+PW3M0rUk4Bpvdc+D5FHfOucTrhIrqHQkkqto
	8hKmSWhSnVtrDNU5YcPNvxR7mLnjQt23Fzi+jyrXedYrRyeu6T3rsOjqvoS0c+zF8oQ1AIxwpFY
	1tpNwZUFmT2J3aPuHWgf78xIE9kOhsxFuttskvFSdDD+698ERNrb9mdJxc/p0fkoaMhkoQZfC34
	jbTqZpbtLrKZOBSRCNE1BS4mkuz2W4UN1Ewk+AWNNoOsmGgiKS3HyHBXSy2KDKKFDK86fwoVVe8
	EpBNqHKO7Lj4DYYe2m4O7kWg+CxFhODBTBTY3PdX0AnnPEslUpSL9G9axZoHE3EMhIxXRKvjp3K
	ddM9tbPn5Zsr73D0QV/2oqkZEPgLDmFUrs8eb8WMUXX5WiH5KsZkkKUfPTl5eRpa6iFP3GX4F83
	hLe2WvbuVwLltgdpb56PWCYDDbqKT+MpNXgpfzaF8meJkkQuhZs61elCryYNrigBN0ZuZf/qRL7
	6NxK/ccQ
X-Received: by 2002:a05:620a:d85:b0:8cf:d62a:c81d with SMTP id af79cd13be357-8ddcded6af2mr3432560385a.29.1776281275620;
        Wed, 15 Apr 2026 12:27:55 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f31f5062sm190136685a.41.2026.04.15.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:27:55 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	"Luis Claudio R . Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v1] rt-tests: hwlatdetect: Add --time-format argument
Date: Wed, 15 Apr 2026 15:27:29 -0400
Message-ID: <20260415192729.175250-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160346.230639-1-costa.shul@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 at 18:03:46 +0200, Costa Shulyupin wrote:
> Add --time-format argument to customize timestamp output format using
> strftime directives. By default raw timestamps are output for
> backward compatibility.

Hi Costa,

Thanks for this patch. The --time-format feature is useful, but I have a few
concerns about the implementation:

1. The format_timestamp() method assumes the timestamp always contains a
   decimal point:

       t, ns = self.timestamp.split('.')

   This will fail with ValueError if the timestamp doesn't have a '.' for
   any reason. Please add error handling.

2. There's no try/except around strftime(). If a user provides an invalid
   format string, the code will crash. This should be handled gracefully.

3. The use of a class variable for time_format is unconventional:

       Tracer.Sample.time_format = args.time_format

   While it works, this makes all Sample instances share state in a way that
   could be surprising. Consider passing the format through instance
   initialization or as a method parameter instead.

4. Minor: The comment about "Float precision is safe for microseconds until
   year 2242" is misleading. The issue is that datetime only supports
   microsecond precision, not nanoseconds, which is why the custom %n
   handling is needed.

Could you please send a v2 with these improvements?

Thanks,
John
