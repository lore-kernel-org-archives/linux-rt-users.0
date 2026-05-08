Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E74410D0F
	for <linux-rt-users@vger.kernel.org>; Fri,  8 May 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261660; cv=none; b=Q2S43ZTc0/fguerIqHcVlmIGGGJjm3mtS6l6pCfb21kNV1fCayPmz7WsvKOlb+I/BqZiCH5PhrHWUuHoZ6XQs5jm8ytIFqVSndQmlLiRn4cJ2cVPdPvy5KPzbxiT4+ig/H+CRuafqJDCa/XUaA27+4AloEn2foobnmfTZGWhOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261660; c=relaxed/simple;
	bh=4VuR2NimOy8C/orc69ZIkLF0F0th7/6/AVvOZF3uihQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyFOZg9gL8wLHwkN+Gc/+SFvasmE4UUDdZIaeDl0Q0bONLaDFMVq91SsiEZAAHVQNUZBmF7xsjqryWOPgj0DaeO2+HridBEGTk9SW/swKAlVAP4TuRHWHLneZMzTLryVvSAqyn6fJ7nljuidrkyuI5C9c5Dk5Fu7MzOZ99WwO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i++Azq4P; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i++Azq4P"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899a9f445cbso20599326d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 08 May 2026 10:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778261658; x=1778866458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VuR2NimOy8C/orc69ZIkLF0F0th7/6/AVvOZF3uihQ=;
        b=i++Azq4PI2cAwESI26x+2sYOPPhkJTj6DZydKZtbICS9mua7o8kDn37w/m7zkom8aW
         owNm310+W5egicVp2XVMoAYu+WUyV29BPGLVspK1WAlT1Td7mCHWbuQx680iuLFT3HUl
         fwPZAJgTOj8dGesqNVrUJO02zqOw27cjhXOEEvhWKJhkG8Pn/tViO7hbuLVmPC5JYQMi
         FxkE2a/JIVKtkCBKY2h/Er8P/KdW+xkn3Aj1PdOBDvH78u4nkd3CW7+Es7S7cSBSFnxh
         DwrpKhXpiX5IGFV+HC/n0sFPb/sK7yaWVOK7Fn0rpfk9fipLPiXrlRin2ge/opaVLvOR
         xnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778261658; x=1778866458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VuR2NimOy8C/orc69ZIkLF0F0th7/6/AVvOZF3uihQ=;
        b=IXCIyNenTJeRivkytr3SKxSNyBBlWkvGEqsVcdpkTo9LUsBSiz2aoPgzHCbU9h1ijM
         MgRc2dwVsmv7OVHAZ+RuId7EIJGeoZCiFEC9CuzMbScOIDb0TMDgPSOREgnuCfagGQ63
         XGeiLD/TIUOKbwCvneaJ0NnvzkrQb2ndC/0VNnTsP5/3F5doSctSdYdL8GE12YvWjM2Z
         6zuLvt3QomymSKdTFIm03xN4IJbq4IXWQ4g6m3QKUDFy1sHj6kYZ3o1TPPD7AlsBlM/t
         VGWPSBQ4+oc585RIsRhP4qf+mMxRnY5MSC83TlMFTTfkJvRMhmKMCKAwlpcLxvRasgjX
         EcUQ==
X-Gm-Message-State: AOJu0YyWCiDEDxhC9mlmSnuBRqXt9YpWSZl2GAKLFTHTvEjaywYw8Tkj
	cK5iG9b+mEWp9DzGl4Yywke3nW2xEQJxV+a3jSVkGIRE/q8W+WgHmjs5
X-Gm-Gg: Acq92OG0yXeP83krkjnCo2XnhFx4DeVch9b05vMHZuEmMgEjKvCkSYMUBiWtqDj1DGk
	9Gpd0M4/8TQKNOjVaKCrnPvwg0zIFzv122xdj0eDpagwE7kvDOm291p74jcCO8tecbWeMnw80rj
	4OcFre+qhTZTpEh5K69n6OF9nj1oOeEof4/7Jr6OrAaIIKXywF7Ef9Sg7t4FfbucWbPrdsI5G0h
	0gXBZnS0+1QL0F3zpBVN1pnwV9S3gdUgToef7dBQdabSZLo3D9ImY6UWY/kJ9Ku6dV3O4q1Eqqd
	vQWFxM+Dd9ym8biYBefGoAMI8KeEZ+TqtNgW5IPnRTPpRvUiaFGgPvIakRn3ZJ45qCn+Fyhw2rY
	kjQBfHqaczOUxANYPu4we5ppnnO/gEg/4EhhQz7aHYNdMo5wvsTqCNy+V2BOUzq9gp9H4m1hW3M
	K7r0GdwZ0tI1c2c8IlC6n4FL/++/vDh2GQyb5q7HphOa6xPdq1ylTVNvbMsENsV/6nauZgP4Mf3
	vweejXZrsV73q65ypU=
X-Received: by 2002:a05:6214:dce:b0:8bb:2e70:7a2b with SMTP id 6a1803df08f44-8bf419c6fcemr50994196d6.15.1778261657451;
        Fri, 08 May 2026 10:34:17 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3addb3aasm23920926d6.10.2026.05.08.10.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:34:16 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Add --time-format argument
Date: Fri,  8 May 2026 13:34:00 -0400
Message-ID: <20260508173400.109690-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260426140115.3111177-1-costa.shul@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 at 17:01:15 +0300, Costa Shulyupin wrote:
> rt-tests: hwlatdetect: Add --time-format argument

Applied, thanks!

Signed-off-by: John Kacur <jkacur@redhat.com>
