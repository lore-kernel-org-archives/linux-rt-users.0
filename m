Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771E25BEFE
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Aug 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583969; cv=none; b=QwRt2F8PtpADR75dPHx2CtSMSi2yuSKPdGr9Xcerq0DhnPI6FYO9Cqm0ceLqMft6xE1SXzE0lruCONEvOTSPHmFRcND6hyRaBmIyk3J60N9ac84Gu+f2cTt3lr7gIZ4VBkdSQ9wbNA5cq1MgSiknHcyVQaH0z29coggBk/R/bSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583969; c=relaxed/simple;
	bh=6NSvF7tziXEfg8IsrhnXzHpNhCOIcWMPdyWEMGMtm7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI7HZWU00UjJUldnnILbD+RssKOp1cPizW5Ki6BoOkN/I23IK8/eiVwJuWYRTjreCXazCdJWvoy+mcxBf8e9DtqYBymNBKeajGARecT3ow49VOsCPyFOwe97+UT/MU3PDoFn+Sjg1XdXYJzfun3SlQ85GHuNM0Sd5kZSaEMmozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3toYMmt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3toYMmt"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso1253593b3a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Aug 2025 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754583966; x=1755188766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTjMTKygwuC1+F81W1q4vOQVyHN6n2Ur7/gjk+aFbZo=;
        b=O3toYMmt/zFtsrRE8DSZw1jgc0EilWi5fgiCju1mgxTZGeM8uAXdjG7dH8bt5UKYns
         pqXXyDJAAoLKUaKoD/U+iUiS+4ftxZ4nhFI1LXnm4gLJZJgJ3eZ81xu1s/LjZRCYbIO0
         8E7X2B064RYP7APf8J5+nhivrq99rvwKpeVeCItGUY4raswzFRQSucLuAQjxrJT0FbCy
         MIdijEng4t98c7RYursrhtWFs6Z4E8VoyY58BROwbKWo6OCL8waLeI2cPGyfdCfDS9A0
         vaUrRo6Fbqy0wPXCkaWGziroL0rZ3lT9vEhvABLI1eaKOcQQO2HtdS2/+C9jvPVYwXP5
         ZOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754583966; x=1755188766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTjMTKygwuC1+F81W1q4vOQVyHN6n2Ur7/gjk+aFbZo=;
        b=XJAKRWY9kOSYBxGyOoCYEDCvn+aG5KQwYfDz9L70jgfSy2w05ZIBJa6QliLExm7fsJ
         Cw8Oh57U/OcDUkyhrLjXUNOGn4+UXcj+NQrH9PjKkDXPPfm5Rt2cw/w/RjImlomFfvm8
         4YzbEoE2oy2+qk61KPqEIqdfVMxW+NXfdbqFZTYAlfLvrtESUZEQQ3TVaQ8lF4zqu/On
         jziMWsI+TH+Kbb9q2Z2nD5UL0VaSNxTpxqNohiMJRS/QkcF1RUnzmaKW8ecsouyslsdx
         pN7I8VmmgSu8wqIN10OvHeW3vhndI7MYmYhkfKrRU3UlLGrGh5QSEjTRUu5x+Vg0AwqT
         fG0A==
X-Gm-Message-State: AOJu0Yz5KJTTK2snwPRGjpX2kscUKrSvatLCalrR9pLb9rXQNZKBKcal
	MWNyVJXf+YajcUeby/dQlIo4THg/ebM8LNUsS56SINybA3ZD7opv4qq1goTeg0mQ
X-Gm-Gg: ASbGncvtq3/Y5Iets43GF6BM3FM5pklyRvIGKh064Cgf/tULnR+pAAQt5UHzexfojgd
	Rbfd8o7gg/ohJnG0X2aDTdBtx5dm8Ios1Dg7f6AWKzsmt4JFjqf725+zrc8eJVmOsPKZgk4+r5o
	np0B0L0eN3aalvz9YyUVmMT6SS4LnLrXFdUIuj3N1CDn5uosZCMz79zlAWtt90S+kNWr4KT6iOC
	+oIpxXygNjw3Jfbu8xX1hXDBg2kFj5uyFmdRgmiFKCNIw3QTj+WvEN/g0jb/NQ5TyJWyZNH9Wnz
	Sal+TU/1XBolT6EFX0JJCA6xParQngpscLfAkPZRff3/kKk3wboc0jx5EIt60Q1h64kUiKoyvWD
	MxDLNJvjspwvEtKNUY3N23yOnJgjH8tPGPyseKQEYNQzEysh/vZ4Wp06Bh84=
X-Google-Smtp-Source: AGHT+IGb1q6NKoIIGjzaZF8+bS8qZcva6dCVUh/Ljic6Eg0i9NnMk/PNtx03q6RXbopERuQxJ1q6ZQ==
X-Received: by 2002:aa7:8885:0:b0:74c:efae:fd8f with SMTP id d2e1a72fcca58-76c2afcf8c2mr9600999b3a.15.1754583966015;
        Thu, 07 Aug 2025 09:26:06 -0700 (PDT)
Received: from eric-acer (36-225-80-170.dynamic-ip.hinet.net. [36.225.80.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdd2725c9sm16219781b3a.6.2025.08.07.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 09:26:05 -0700 (PDT)
Date: Fri, 8 Aug 2025 00:26:03 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 0/8] Fix -Wunused-result warnings by checking return
 values
Message-ID: <aJTTm--AyLQWFmHi@eric-acer>
References: <20250726091837.493915-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726091837.493915-1-yphbchou0911@gmail.com>

On Sat, Jul 26, 2025 at 05:18:29PM +0800, Cheng-Yang Chou wrote:
> This v2 series adds proper commit messages and addresses coding style
> warnings previously reported by checkpatch.pl.
> 
> All patches have been verified with checkpatch.pl and show no errors
> or warnings.
> 
> Changes in v2:
>  - Add commit messages to all patches
>  - Ensure all patches pass checkpatch cleanly
>  - Link to v1: https://lore.kernel.org/all/20250712134213.58582-1-yphbchou0911@gmail.com/

Hi Clark and John,

Gentle ping.

Thanks
-chengyang
