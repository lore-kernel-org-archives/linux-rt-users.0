Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D31E189BB6
	for <linux-rt-users@vger.kernel.org>; Sat, 23 Aug 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755952833; cv=none; b=PMXsoCt5nIYiTKOyoOmGbs/4qYZiq0s95GEkxgQGAG3sZRqCTCorrv4JREy/sis9RzpHmxkQElDPBIapdeQXunX3x/stF4kGfUynLTHp6Op575k0ZAbCYXorUtpjd9iYYsRMcrltG2dDjIc9mTmyMxhHtCPJc9IKXJy+bDQfFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755952833; c=relaxed/simple;
	bh=VLfvut5V96kW6rArTq9/56uYtB9Rj5vzGtkrfWvSNOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQalF/n5yt4KM/hUI2ziUktz18dhBQ6po4KQu5aXnAPQ57oN7EmcDfdUHY+R6kWYXzMb9eJ/sNc0KGRs1LKSYcYkclYb7MLL7KYC0yU6jUoPJcOwSUciXCWWyD2J2PjqIOdB2X0VUtBw8JSk5IeVuGBH2mOFVBxObEDuy7veT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD/OziDr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD/OziDr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2445827be70so28096675ad.3
        for <linux-rt-users@vger.kernel.org>; Sat, 23 Aug 2025 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755952830; x=1756557630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NP3mVPdKEg8OEyswXwhBPnkPCMczAVgjaizwcSUFkTU=;
        b=FD/OziDrlSDPw1+R2Ou8occjLCav6OlSWwLS6cUPcN9OV2GQH5feG+U+WmKFt/XwpF
         h8CG9ADFN+YwMzOckWQRiND2SsPk1aSpQ23pIiN3W8IfCJT9yqx6PwC1BlO6x6B1IDn4
         kbrNHtjCW3YsH6tnZ9r567mOT9/6zOYoxU3vC19VvrvAvpkj3DVayYnZBIrK3ftZ1F8x
         6Tc9AbAAD1f/IiGoSX+jb6qbFXI/EZI03AHAKdYw3A1a/70fXnAEjz1hAnSdPqWa4mVa
         DwMhS5nnYyjljGDKzuZSWgfgIokS1fWgFqJV5BWdJW0B737LbAcXXBNqvuDob+Xw1XQd
         MMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755952830; x=1756557630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP3mVPdKEg8OEyswXwhBPnkPCMczAVgjaizwcSUFkTU=;
        b=fE1HSTl+r8wPbOYznrP/Dgk3UG3qvTKgh9ZlbJO0Ev2IkLEyFrwOrP3SlreRaIkzpR
         qH3ksGikIx0p7IRVxOqkwCNh3M8ITmXSiKS2xBcwkNtHbSJBLWM4mKS4ogXQECyotCuX
         eJhxBJ4N3jstyZvbaYkvZNX1kiGlYkAJDz5awZeu1FkZqu4Qj31/WQ1Sbn32uKrKD2Be
         bjtwA2lmHfpg5Nil+xs518gyiqx34juCZyBCE+vsL8TRmynDloDFCwBKEdlr9q7V+LbS
         id25aEJNDbuFt+za14SQO5tHVVYVSScPQiRBqEoVPf/hZGrG8SNOue/YUo7UaGVodItk
         +MfA==
X-Gm-Message-State: AOJu0YyaFoD8+I1ajGHnWwelOHEWUnkqp4hQUYTexU4SVnKulZCuwbe6
	MVHhjYVRIZNgobGDKowIfWq2D331jOT5tLE29JVzseILV+H9rZFgl3AS6EcRaFuf
X-Gm-Gg: ASbGncukm8FQJvDI5JYA/3hR5QOBve+UmnZRgCcHe6ULhTOrRug8plnN3OBDbq69Eo2
	SVoaPaXtABQwm4YFKuj6cCv0i6nTE0zS3rjRn7IlOXOKNYtPEGA3edJvg2VI5vQld4TiPyxouLc
	C0f9Y1/kNI6bpxZ9FU/liaK5a/+gIErHmeVh5iyaeB3BdFvUO8Q8zr+tAE1eyHfGUE1D/2Dtdvu
	6ssqaqoElsWXg7SAyoCMI2QgmhfWUDT2mgwP/IYecW9rmV0bh7xwYF2tbNlNgHg9yCNDjzeH0Za
	GzXuRSAGh3KdIjdRCvXNH3yCfR6ZqwGmJdPDbcY1Hdvirx1YcMp5PZ8xjx/NXCWul2PSlNqOqFm
	AkLA5s4JmS3HJXMxNGnwK1x9e3y43CQKncx3UQAvoEoDOCESmPvHpJ2v/jZ8/5B0PiNQuaACDKq
	661AwcjmQ7oP77
X-Google-Smtp-Source: AGHT+IEuM1c6CethfNt33kr87fXnm1dxziZGZkngC1akZF5DksxI7AjihV0teJzk82LFOIXMaw3Mfw==
X-Received: by 2002:a17:903:943:b0:234:d778:13fa with SMTP id d9443c01a7336-2462ee53d3bmr95302895ad.26.1755952829785;
        Sat, 23 Aug 2025 05:40:29 -0700 (PDT)
Received: from eric-acer (36-225-90-82.dynamic-ip.hinet.net. [36.225.90.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885f2c1sm21650685ad.73.2025.08.23.05.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:40:29 -0700 (PDT)
Date: Sat, 23 Aug 2025 20:40:26 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 0/8] Fix -Wunused-result warnings by checking return
 values
Message-ID: <aKm2uqtfTyB0vrDc@eric-acer>
References: <20250726091837.493915-1-yphbchou0911@gmail.com>
 <aJTTm--AyLQWFmHi@eric-acer>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJTTm--AyLQWFmHi@eric-acer>

On Fri, Aug 08, 2025 at 12:26:03AM +0800, Cheng-Yang Chou wrote:
> On Sat, Jul 26, 2025 at 05:18:29PM +0800, Cheng-Yang Chou wrote:
> > This v2 series adds proper commit messages and addresses coding style
> > warnings previously reported by checkpatch.pl.
> > 
> > All patches have been verified with checkpatch.pl and show no errors
> > or warnings.
> > 
> > Changes in v2:
> >  - Add commit messages to all patches
> >  - Ensure all patches pass checkpatch cleanly
> >  - Link to v1: https://lore.kernel.org/all/20250712134213.58582-1-yphbchou0911@gmail.com/
> 
> Hi Clark and John,
> 
> Gentle ping.

Gentle ping.

Thanks
-chengyang
