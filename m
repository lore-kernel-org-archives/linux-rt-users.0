Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2C33E7
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Sep 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096826; cv=none; b=HeDn7OK0Vgqn8PlroycIlrgMGjEmJetiDIGmtkGLIrDhX0fRAskS5rJJrVQAXm3PAyIFz/t+3VwDD24x3ozVNuDIaSCajiPSADjYoLgyun9q9CRPwuL61EMCuygkZ+KwZvshzl1W8kiTGPtiLD2GttghDA8JC3RE+JE5c/XXtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096826; c=relaxed/simple;
	bh=vojnr2nkIc/2kG05LRQR4U5IN0rakfQ4vC3aD1i+lLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYLFB2+iZ0gFViIIzRzRc1bApVnWD9cAI8nB3VgH+QT+CTtAtljMlpeV6Tw0FTPPgvUrtYFsL5HZuh8ctsQ5DVI36OiZFVWPygtIU3BWzOCYg83QcDiAxJ9IziyU0RxGnByYyOlwZ8pcAMNaxDtt4ZTAfWAvWRXW+oi7xG4Totg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtKd+kE2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtKd+kE2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so3213497b3a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Sep 2025 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757096824; x=1757701624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kROpUvWqlCwgs4fyMvAKUdmGaRPI3XlX8wwlPQD5XCw=;
        b=RtKd+kE2QFcOLrQKv3pD+e72B9Tuf9H8nmF1hU/lGngakGrjdCnUBlB9zgo13QC/Tl
         9T/2lZcT6nHV9ixjagNNYrVycGgFmDoTnoLXuMWTQwee3uXTgCANMl1i0Bdy/K9SpZe4
         umt1AnT2VZuCYzhod/374R/WyJW+nyJSxD3wdgwSESU0IVTkZ1Hz5BrDmAhtHEWpiiI9
         s2KS/3OH0eR7+hnVj1+jxClMXCosXIVwzfxtR3LsTthOthhjj6zxKqQjRYAfcrsDMBbN
         VPLaR46hzNZ8pdbpar7YFNJfPEfbWL8nYi1Y/Z92eDFbQTJXMdCOKX5thAypFwDhjN4P
         4b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757096824; x=1757701624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kROpUvWqlCwgs4fyMvAKUdmGaRPI3XlX8wwlPQD5XCw=;
        b=IK6rfFnAAQEVIdfXaBfWawnB3IFspi4TkxsdrZw8/i9JCVGPBBRwqJvlOkoHLlBLZj
         qVKvoMZLmDOfeoBDrCy2Hgyyd7sEP7XX4jvWi4sUkuwvpA88wRcsrIheZzEmFQieDAuO
         5n0QnbzD8MmTdSzYGZkCGBXd4yJNVaUtBagm6VEeWzDpxJxRpJ8RjEyd0IG/+KY7SKC4
         JC2uhJDJ2XlhG570Nklz1H+2vDvX84gtEBnp++uf457J31pzkve3wCtdaB01yawXEn38
         tJ6/tkLNJeFT59intyftdvpMxQayyJQ24ucVD4JPWRDYoGst755ZoqMQzhSoLcJA9lCb
         Zvmw==
X-Gm-Message-State: AOJu0Ywq4XtTuSIJ8vY4u/SQ4ULyG02uDy2+5NidQOj0nbit9IS0ctri
	DbruocxW0KPDs0jLs+J2vl+9Iip4wR2L8jcilEm/pr0rQdyO7SNSsCyJ
X-Gm-Gg: ASbGnctSFPzSh1TR8Lr52MnfxgazR1oML3j7X7mzdHe9ZavfPmtIHlPED3oLrpJvdU5
	GrYyyG8AHuuKXP0lE5XJLsxxJE1O7Dgi7y9sBk1R5Vx2Fc+J3BxqN+O6GjluYtRh5lyyV5Nvw9n
	kQvI6FqEfEoLRbhbBEjvIPbU/odj49uR7j8MQ7bX1vTIdN2ihCM/gFjmMItRLn2OotKgCyGyZVe
	Z1HrNtyi6fcMmE30++XCXdX+tgLDwVOu8KzBB07h4Os7IscRClCFlESnMt7xh9DeUsAmDReZC4U
	B1a8fwhZPkZpJIjS7YAwQqUpzuDkN9xB7SKsYDGR0q/pnxpXSr8Kh0yv2MzYRnYEz3wLVpwkzym
	Gy7pjvZodUdk76DT3daoIov6/h7bDo8N7YutmTpaiD60gx2fXqxQxjpjJ
X-Google-Smtp-Source: AGHT+IG8XAoIt8G/zLumRDb7HVtIzcv4wDqqo6K4Gxvs+tEXk1TZNtF6uB9tlqXKP8qj7NGcTixgtA==
X-Received: by 2002:a05:6a00:190e:b0:771:ef50:34d with SMTP id d2e1a72fcca58-7723e36284bmr26451219b3a.16.1757096823847;
        Fri, 05 Sep 2025 11:27:03 -0700 (PDT)
Received: from eric-acer (36-225-64-77.dynamic-ip.hinet.net. [36.225.64.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm22397681b3a.48.2025.09.05.11.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:27:03 -0700 (PDT)
Date: Sat, 6 Sep 2025 02:27:00 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 0/8] Fix -Wunused-result warnings by checking return
 values
Message-ID: <aLsrdEeEzmTFIbRC@eric-acer>
References: <20250726091837.493915-1-yphbchou0911@gmail.com>
 <aJTTm--AyLQWFmHi@eric-acer>
 <aKm2uqtfTyB0vrDc@eric-acer>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKm2uqtfTyB0vrDc@eric-acer>

On Sat, Aug 23, 2025 at 08:40:26PM +0800, Cheng-Yang Chou wrote:
> On Fri, Aug 08, 2025 at 12:26:03AM +0800, Cheng-Yang Chou wrote:
> > On Sat, Jul 26, 2025 at 05:18:29PM +0800, Cheng-Yang Chou wrote:
> > > This v2 series adds proper commit messages and addresses coding style
> > > warnings previously reported by checkpatch.pl.
> > > 
> > > All patches have been verified with checkpatch.pl and show no errors
> > > or warnings.
> > > 
> > > Changes in v2:
> > >  - Add commit messages to all patches
> > >  - Ensure all patches pass checkpatch cleanly
> > >  - Link to v1: https://lore.kernel.org/all/20250712134213.58582-1-yphbchou0911@gmail.com/
> > 
> > Hi Clark and John,
> > 
> > Gentle ping.
> 
> Gentle ping.
> 

Gentle ping.

Thanks
-chengyang
