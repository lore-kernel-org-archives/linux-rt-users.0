Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B3225415
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Feb 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591692; cv=fail; b=RVk7OtznDsEYEh+TmpEz/4LlsxWaBolL1zE8x0jmo6Qg9FtIneO28Qe8RvGOWHnUdhcFDMdLjtI+nIBccO++RMGsfdWxkgHEjDi6m4SGtoGbYJygk8gRRF4+hcDfMUfAXELpoER7ANgeMpHgJYNU9JMouXUNtSOTbiETkYxzzMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591692; c=relaxed/simple;
	bh=9o18L1KN2zlvzjrhZvewN5KgysQJRI5wgJf/OgLZiYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7H0x0/wZqtFZksebf5T0J64j/DlVLdjZ2AnRiqzdkUvAnh4DQmwgf1FpK235JN6qiPStmsNzGSBXKPyT9zkPtVm8ciyqYESoZ7+3piJHNGh5UUKGyZP2eh/IfA0JkvkICKqX5h3FQCbCdsu8+r3nhZl525scB6cVeFaAWSBFP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YEd9oeR7; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YEd9oeR7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kemebsMHchrEXObVPc2TCsjYP2rPYFqGhsPPUVrcP5WTZkOT9ZBVSeiBXf/N56NJanHgtvRhPfBB8QC0lZ3ZsddAAWowWjrPI+uNesD5AiWXQGaEWwPNlPxR2xvzocsdRTRf2OvmnWvS5piUQu89h9Ut88wRXei13FSVU7RvHeadb603//VB8awiQZx4RmBtIzZ63sH+egK8R3XX/OrT7Wn/sLgPtGbtPaP0KLF3DnAcoSR2b3pGz+c5WJgPOCAFvNJ/WiNJupvRQ1Oo2E5ZUK4Oep9MwABZauv9hjf2qXxmex3EraALKdqCK+wCyOG7q11HLSLu3QIgpKeYNy1jKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o18L1KN2zlvzjrhZvewN5KgysQJRI5wgJf/OgLZiYk=;
 b=KIsgvZVjAd4uuUCxuqQjbIpezNSZbBbZwP8FlTOjcm/WIATLSOAg54KMFdTb8In5t2HxsiHlVIhpYng/OGinRUvgdmqZsaGgxpihnc+v38wC0GnMfFgavlSBWqOz4Vb6XRwsb7OztIFvIwfZy5gYrT6P/qGDLdzUa841fQcyeQx34M8DpjBAkUvOkAQ/PlszI4ivAXBtHaL09BI88SENsrQ1aa+chw+u7I+JHXe1M+uMqVghC7FF20IGHBjAgMkJY6CDNy/+Qxyp1joFdaT36qOlSBUlkhS5Hz4Mby9oscXAmDglhu90CHvJdUpPz4h0EmCTGSU8RgUvgyiXQtP2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o18L1KN2zlvzjrhZvewN5KgysQJRI5wgJf/OgLZiYk=;
 b=YEd9oeR7KKJavKV5Jxnjr+FIwOrbD6TQnmBNk0c8r+cir3ulHZ9Hvldh30DjzGHdvR8nPlyhXqHBK67OvRZMbhd2MT3H4Ih7bKCbw1cVKXEIgObejfVb5nLD7jqebsIu8Mj88lloMgSDPLfBvsyMBodymiUpeD6EyynqHflbgioBRUIk/LbFlh1+y4imvgpjtqfVxjJtFB04EdMe8vmU8CR/KA0X7nO8KFo0qFfARhmCLjfhrTNdRXzD/125igW8baYQr6tllqepl0cdOHuuRf+8puoz9cpld59sC0NGueEGJk8XxUMsAk7OsUSlIhSrPzyBHVfIGe1eNNUxtTOgfQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB4PR10MB7014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 17:41:26 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 17:41:24 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>
CC: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Ziegler, Andreas" <ziegler.andreas@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: 6.1-rt: NOHZ tick-stop error: local softirq work is pending
Thread-Topic: 6.1-rt: NOHZ tick-stop error: local softirq work is pending
Thread-Index: AQHbhEONrX6veFEDmEuM1NgTs8xNfrNWXZmAgAHKWICAAS4nAIAAjK8A
Date: Wed, 26 Feb 2025 17:41:24 +0000
Message-ID: <26f06dec0e02bd5c527b4c606c7f424f7b9d9837.camel@siemens.com>
References: <73c50e2fb53ba8cc2f1538abccc42e98fa63159b.camel@siemens.com>
	 <20250224115557.AIFtijeu@linutronix.de>
	 <d31ddc467399b53c3f0687db63cb64a3a7c77ca5.camel@siemens.com>
	 <20250226091752.jCsLqq66@linutronix.de>
In-Reply-To: <20250226091752.jCsLqq66@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.55.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB4PR10MB7014:EE_
x-ms-office365-filtering-correlation-id: 6808fa99-2fae-406d-bb74-08dd568cca5a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTVQZHh4VzVsVXNLUnhQV2FwT0hWdEpwVUJRbCtwRC9sQTJGaHVqR3dVTFdI?=
 =?utf-8?B?b21MMW10VDU1dGNuaWV3NlVsNElQWlJJdVZSTERidldBc0t4bDJLdERlcEU2?=
 =?utf-8?B?ZGNQMzJjc1NUZCtqOWVIZy80czBTUk4vUG9ITUo0cEVpQmh0aUhqbFFOQ3ZL?=
 =?utf-8?B?VDlqYmNJejFWekhuUmpuWmdrZllHTElxRWo2eEdEZm5WdXh1RmxvMmQ0Y2xl?=
 =?utf-8?B?dnlQNGhoZWJpclJLa2F2MERsSmpudkNQajg0Q1pyNEFJbWlkQzNzTFlnNHZN?=
 =?utf-8?B?STlrVCsvTEJVK1lPaGV4dDJVdzN0c3pMYUh5T2ZqYks2Vk5qb2JnUjMxb21L?=
 =?utf-8?B?Q0JPK3pES1NHNzU1U1VvcXgxY1Nrb0hldXIyUVdVRDhQS0Y5dHVBTnFlQmtO?=
 =?utf-8?B?MjJuc2VWTVRzSDdJeVdWR08xV0hJVWxFRDcvUEtMa2ZicnZoem42UGhyNFMv?=
 =?utf-8?B?cTgycGFOR0NPOU1CN2ZGOU5GUWpWeHNiemZEZmwrOWx1N2M1alVvNC9jZXRj?=
 =?utf-8?B?OXR1aEpjTkxkVXNYcnJReEpTWVo4ZjFMK0hzQldzSWc3MVd2cmtRemRSSFpM?=
 =?utf-8?B?MHBWaXZxbFRlbVp0Z2kybFNyT0lWQnY5bjFzYTR6dy9RYWhIR0ZaSEMwMjJl?=
 =?utf-8?B?SHQ2WW9NbC9aR2pNVUsxMC96NHNza293bkF6bFprRU1uSFdPeXorbTlvblFr?=
 =?utf-8?B?dm1GSkRJZjEwK3F0YVN4SlZHZFA3dHNhajEyY1NvRWY0VTJmbmIwdHY0QjFX?=
 =?utf-8?B?cVUyVjgxc21jMDZBdVgwbmZQZmIzUDlObXpWMEFjWkNKL3l6U3ZBOXU1c0hn?=
 =?utf-8?B?ZVVNUmQ5Z0U0Nm9DbXZ5NTgyME5zcllXTFhYMHY1Y2dUOTY4M05oZmFDS3Fj?=
 =?utf-8?B?dnM1SXVpY1ROL3hkYUxHdGFsdUhPLzFlVmZHKzVvOHBFenVLZEVYSE5zYWtE?=
 =?utf-8?B?dHJGVkg1RlVibEhVTXhCTFlsaW8zZDljUXI5dG90WjRucC9wSnhmRlhsMVAv?=
 =?utf-8?B?Y09TZ0ZJTHFpUXQ2aW9sY3l3S3FDeXBhUSt0NHNnTWJQOXE1NFg0ZGZZc2V5?=
 =?utf-8?B?WHpNTWFwRUw2eHp3b2N6b2J3b1VreG9ySk8vajR6N21LdWZpejc2Q0Z1K1BB?=
 =?utf-8?B?L2dnSTBVeWZIZ09JMVkzQndkOEkwRnlORElGRnhnMkFUZm9PL24zSGFva1Vk?=
 =?utf-8?B?amd6YU8yb3I1Zld4RkhGc1BZMnluTjdOTWpIcG5Oa1lrQS84ZytBVVNYeWxq?=
 =?utf-8?B?ZnVQcnVaUFFlR2dUbHppdkpabEhFNXY3QTgvazJUVU5pTUxNcStiQkRmQ3Jv?=
 =?utf-8?B?YzBVTW1FeHkzd1ZYTWhXaGNnSHg2WVl1M2oyVTNjdS9LNU9RblIzRy9aOHZz?=
 =?utf-8?B?Zm9HY2hqd3N4OW9BVC9kY24rekJudTcyZU81VWhvNWZianpXNHVScEMweENB?=
 =?utf-8?B?cXd0OUtvUWtlRjZRdEd3Tmc0dW1kZDhrY2UrcjgxMWRoZHBLRkJqdXM2anJ3?=
 =?utf-8?B?TEpQUjVqRXJmRWxPejduR25jMDVCbWI3SlR4MEpwVGNCeWNMcythdDh2eTRz?=
 =?utf-8?B?UmZ3SXNhOGM0dE5IRWhkdXlGdUdFRWp4UmoxaTFhU1ZSKzUzYWdwZTFMWFRo?=
 =?utf-8?B?YnFRSVU5ZjRpV0Q4UElJUWdOYkRYSjQ4OWpkWHdQUXM2M0RINU53djBjYnE3?=
 =?utf-8?B?MmFJUFYzWmdwcUl6V1A5cnpkZGtPYVphVUxCSDcxajVhRy9nQU1yc2E3MFhn?=
 =?utf-8?B?OHl0bS9kbXgrUTVzY2U5S2R0WUx0TXUyS1M4akVJeWFPMXgycGw4NUZyZWhT?=
 =?utf-8?B?RTNpaWhjV3BvemRYMDhlSGpFeVZGNzc2cGJHUE1yUjhWNzdWL2gyS2RiTEN6?=
 =?utf-8?B?Vm95VmR2Wk5nZjlrbnY3MkIwUmxvRm80dXBwRXVoQUVlZS9ScjBZbS9Eb3VU?=
 =?utf-8?Q?8gFhNO1Md3KRsxXjW3tVXS8lMLCohuLQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ymx5OVY4TmdrS1hlSUtwUlZuaTFZOWYzVTJ0cEZwSGFkQlBJbm5BV0lPcHl1?=
 =?utf-8?B?anJiaUt2RnlvZzJ2Ty9INk96V2J6dWVVcEZkMjY0R3ZaUUJLUDlOSGxiSTZV?=
 =?utf-8?B?aDEwZXBEV2NkSXB0WnlxTjY5aW5oQTJkQ0NDeHFidEZPcW9lR1hOQlB2U1Jp?=
 =?utf-8?B?bnMvM08yQmpsbnp2ZkltSW5mZW9CaTltOHpHU2lpWml2ZGx0c0gwYmlxMXdq?=
 =?utf-8?B?Z2ZVOWRmRHRQTUlaaEFCbk5jU1NyNnRoQXNmVkpyNyttb1lNOXFvbVdoWFhq?=
 =?utf-8?B?Y01qb2pjd3ZDZFUvbURyc0xlWnVQQ09Xbmc4Ti9KWEw5dUhEMTJSSjBTazdB?=
 =?utf-8?B?V292c25nMjcrK0dpT3pqYW1ubDNTVldkVU8yUkU1SzdOQzMydzNLTGg4a3FT?=
 =?utf-8?B?UVdCV0p4azRQVERwSnliRnA1QkdmVGgzMUJRMlZnU0p3dkUvWVhYOEpNYURj?=
 =?utf-8?B?NVFEakl4anBHNkhhdXEyWXhXZ3ZxTjNNTzdoOWI1cnNXTmU4aUFaZVhkSEtS?=
 =?utf-8?B?UnlsbW9FWjY1V1ozN29wMEJ6Yll5L21vNGpQSnVxdkF1Mzc0RmQ5eVRwZ0xm?=
 =?utf-8?B?K05zcmNEUUR0OEVWRVJRRDVISkZiRXJGTmNtU084SExIUjl4TzRKdm9yYlBR?=
 =?utf-8?B?UnE3a0VmTU1WdmZFRno2ckJVK05ISmYxZG5jQlhPZEo4RlEraHNobDhVYXRx?=
 =?utf-8?B?WmlWR0VlaHpzVmhsZVRhOFJMTkk5a2F2UGhlK0dvVUJ1MDlmeW5TazFlc0po?=
 =?utf-8?B?N0ZnQU9HWjYzcGpnTThFYSs1eklkVmErZlZROUZ2UWVUeHJER1RzSndqWE5n?=
 =?utf-8?B?a3ozQVJpUTVCS1RmSTV2ZzB6N3l0b1ZRUmpQN3p1WWVYMmFQWEk4c3lCNVpQ?=
 =?utf-8?B?K2pwOEw2dHpFVmVrdGRLZzdtSmZRYTM5S0ZMQkVwMlEwWm0wVi9WRzlhNUNL?=
 =?utf-8?B?MzlkaDR2clowSjhNcmw0d0lSenRtYWM4dFgrQU9CTjVKd2FKeDVvVWNOWXBv?=
 =?utf-8?B?MEowUHJTa1J6ZmpLL25KQ2JXY3N3NVo0RWdFemg2SnZRMzV4MU9YRG4vN3Er?=
 =?utf-8?B?ZUducnByQUtlWjh5UkxlNnZzRWI2RjlvY2QxVDdhQXJkT3hkS2xIbjRFZUlw?=
 =?utf-8?B?ZURPWHFZMHAxRVNKMVVxOEFIanhKa3ZQYk5ISUNlZjFYN2d2OE1pUjdnTkRn?=
 =?utf-8?B?ZjRnOXZobzZWcFlFQWtzaWd3a1U5cUJpTXFOSzNTUlZORkJtQ0hSOStjNUdi?=
 =?utf-8?B?MlR0N1hpTkdUYXJQZVA5SzZ2a3lkT3JKbXUvMmtWa0hFTE0vWEFvek1jZ01B?=
 =?utf-8?B?K0JDYm5UL1hueWN1YkYvVWRqWlVJQTZXbHFrcXFNbXFKUzAwbzcvMWJiZU1O?=
 =?utf-8?B?emtKYndaWExNZm0rRVhldG44aEh1NXJlSExlcXlPckpuN1BXWlAyOFNTV1ow?=
 =?utf-8?B?WlhURmxRSTRGWTUwUnRTbGRQTEYwN1dWZVJPOE9KK1VZNHd1QkZGczlhVyt5?=
 =?utf-8?B?VVgrQjdqODluTmQ1SWprYlBONTNWK2dhek9tS2tLQzBQU2pWVU5mMlZNTkFC?=
 =?utf-8?B?bzBtL296eEZibElTc24vRjZuK2s2bDlvTit4L3hobVp5QWN6bjBXMGRRcEVt?=
 =?utf-8?B?SmNXWlFkTFMzUDAvRXJrdkdYV04rNkhiZ3JtUGdEeWhKaXZDWTFhL3ZsWjhP?=
 =?utf-8?B?RDd6MW1wemZqdGZDODVtTUpZaEJQcGxUczJiV09OWXZ6S3gvS0I0QythRjdi?=
 =?utf-8?B?QVFrdEd6cXUvN1phTXYyL2JmVVhkMytQeWkvWHplN3IwM0NSSHJBZnAzcS9w?=
 =?utf-8?B?WW1NQlVGTmhQeXlBb3YvR21PRWk0VHIxUzNNeExGcVpmTnZrbmtseDlKVURK?=
 =?utf-8?B?KzhzakxERDJSY0pWYUZ4N2w1em5PMWNCMllNNEVuQS9ZamNuL0ZYT1Z0MUJH?=
 =?utf-8?B?QWxIUzZhWXdvc3kxQzNEUmROWDMvdzVBdWNvN0ZCL2t3STJnVjN0U2F4dU9H?=
 =?utf-8?B?VnpIMjZQaUN5WU1oekovbDlVL1lSUW5Qbzk1MVM4MWtQbWE0Q3ZMZ250aSs2?=
 =?utf-8?B?cWZzN29kZ2Q4cDdLU0EvdEhzRUVtZjkrNkRmb0ZvQkxZVERZSVQ1YzJ5Yjk4?=
 =?utf-8?B?UmsvRkhaUFdCQTRlaTNKZlk2VnhnQlJ3dTdETXVLT1VLT0FRT0h5R3V3eXhH?=
 =?utf-8?Q?PbKpSFqryrzrGZ6T0C2GO/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E3CB4F828D8D9499A2E665909229B32@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6808fa99-2fae-406d-bb74-08dd568cca5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:41:24.6770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5f7HuFh4iwB/Px26MQp1eCSCaQALac+drbUG3xRLV8n0Ft2OQJ5DYEXis1z8ayjzaSBsN/vHWuYIvYBLjuLK9AGedHnhWoZTrS2o6Jucq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7014

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDEwOjE3ICswMTAwLCBTZWJhc3RpYW4gQW5kcnplaiBTaWV3
aW9yIHdyb3RlOg0KPiBPbiAyMDI1LTAyLTI1IDE2OjE2OjI1IFsrMDEwMF0sIEZsb3JpYW4gQmV6
ZGVrYSB3cm90ZToNCj4gPiA+IHdoaWNoIHZlcnNpb24gaXMgdGhpcz8gSSB0aGluayBpcyBpcyBh
biBpbXBvcnRlZCBpc3N1ZS4gSXMNCj4gPiA+IHY2LjEuMTE5LXJ0NDUNCj4gPiA+IGFsc28gYWZm
ZWN0ZWQ/DQo+ID4gDQo+ID4gVGhpcyBpcyBhIHR5cG8sIHJpZ2h0PyBZb3UgbWVhbiBpdCBpcyBh
biBpbXBvcnRhbnQgaXNzdWUsIG5vPw0KPiANCj4gTm8sIHRoZSB2ZXJzaW9uIGlzIGNvcnJlY3Qu
IEFuZCBJIG1lYW50ICJpbXBvcnRlZCIgYXMgaW4gd2UgZ290IGl0DQo+IGZyb20NCj4gdGhlIHN0
YWJsZSBxdWV1ZS4NCj4gDQo+ID4gV2UgY2FuIHNlZSB0aGF0IG9uDQo+ID4gDQo+ID4gLSB2Ni4x
LjkwLXJ0IChEZWJpYW4gLXJ0IGtlcm5lbCkNCj4gPiAtIHY2LjEuMTIwLXJ0IChEZWJpYW4gLXJ0
IGtlcm5lbCkNCj4gPiAtIHY2LjEuMTE5LXJ0NDUgKFNvIHllcywgdGhpcyBpcyBhbHNvIGFmZmVj
dGVkKQ0KPiA+IC0gdjYuMS4xMjAtcnQ0Nw0KPiANCj4gQnV0IGlmIHRoaXMgaXMgdmlzaWJsZSBv
biB2Ni4xLjkwLXJ0IHRoZW4gaXQgaXMgbm90IG9yaWdpbmF0aW5nIGZyb20NCj4gd2hhdCBJIGFz
c3VtZWQuDQo+IA0KPiA+IFdpdGggUEVSSU9ESUMgeW91IG1lYW4gQ09ORklHX0haX1BFUklPRElD
LCByaWdodD8NCj4gY29ycmVjdC4NCj4gDQo+ID4gV2UgaGF2ZSBDT05GSUdfTk9fSFpfRlVMTD15
IHNldCBidXQgZG8gbmV0IHNldCB0aGUgbm9oel9mdWxsPQ0KPiA+IGNtZGxpbmUNCj4gPiBwYXJh
bWV0ZXIsIHNvIHRoYXQgd2Ugc2hvdWxkIGdldCBDT05GSUdfTk9fSFpfSURMRSBiZWhhdmlvciBh
dCB0aGUNCj4gPiBlbmQuDQo+ID4gDQo+ID4gSSByZWFsaXplZCB0b2RheSB0aGF0IHRoZSB3YXJu
aW5nIGlzIHNvbWVob3cgcmVsYXRlZCB0byBvdXIgUlQNCj4gPiB0dW5pbmcuDQo+ID4gRW5hYmxp
bmcgTkFQSSB0aHJlYWRpbmcgbWFrZXMgdGhlIHdhcm5pbmcgZ28gYXdheSwgZXZlbiBpZiBOQVBJ
DQo+ID4gdGhyZWFkcw0KPiA+IGFyZSB0dW5lZCB0aGUgc2FtZSB3YXkgYXMga3NvZnRpcnFkLg0K
PiBOQVBJIHRocmVhZHM/IFlvdSBoYXZlIFJQUyBlbmFibGVkIGJ5IGFueSBjaGFuY2U/DQo+IFdv
dWxkIGNvbW1pdA0KPiDCoMKgwqAgZGFkNmI5NzcwMjYzOSAoIm5ldDogQWxsb3cgdG8gdXNlIFNN
UCB0aHJlYWRzIGZvciBiYWNrbG9nIE5BUEkuIikNCj4gwqDCoMKgIDgwZDJlZWZjYjRjODQgKCJu
ZXQ6IFVzZSBiYWNrbG9nLU5BUEkgdG8gY2xlYW4gdXAgdGhlDQo+IGRlZmVyX2xpc3QuIikNCg0K
SGksDQoNCkkgdHJpZWQgYSBiYWNrcG9ydCBvZiB0aGUgdHdvIHBhdGNoZXMgdG8gNi4xLjEyMC1y
dDQ3LCBidXQgZm9yIHRoYXQgYQ0KbG90IG9mIGluZnJhc3RydWN0dXJlIG5lZWRzIHRvIGJlIGJh
Y2twb3J0ZWQgYXMgd2VsbC4gSW4gYSBtaW5pbWFsDQpzZXR0aW5nLCBJIHdhcyBhYmxlIHRvIHJl
ZHVjZSB0aGF0IHRvIHRoZSBmb2xsb3dpbmcgcGF0Y2hlczoNCg0KODBkMmVlZmNiNGM4NCBuZXQ6
IFVzZSBiYWNrbG9nLU5BUEkgdG8gY2xlYW4gdXAgdGhlIGRlZmVyX2xpc3QuDQpiZTEyYTFmZTI5
OGU4IG5ldDogc2tidWZmOiBhZGQgc2tiX2FwcGVuZF9wYWdlZnJhZ3MgYW5kIHVzZSBpdA0KZGFk
NmI5NzcwMjYzOSBuZXQ6IEFsbG93IHRvIHVzZSBTTVAgdGhyZWFkcyBmb3IgYmFja2xvZyBOQVBJ
Lg0KODdlZmYyZWM1N2I2ZCBuZXQ6IG9wdGltaXplIG5hcGlfdGhyZWFkZWRfcG9sbCgpIHZzIFJQ
Uy9SRlMNCjhmY2I3NmI5MzRkYWYgbmV0OiBuYXBpX3NjaGVkdWxlX3JwcygpIGNsZWFudXANCmEx
YWFlZTdmOGY3OWQgbmV0OiBtYWtlIG5hcGlfdGhyZWFkZWRfcG9sbCgpIGF3YXJlIG9mIHNkLT5k
ZWZlcl9saXN0DQoNClRoaXMsIGhvd2V2ZXIgcmVxdWlyZXMgQ09ORklHX1BBR0VfUE9PTD1uLCBD
T05GSUdfREVWTUVNPW4gYXMgdGhlDQpwYWdlX3Bvb2xfY3JlYXRlX3BlcmNwdSBwYXJ0cyBhZGRl
ZCBpbiAyYjBjZmE2ZTQ5NTY2ICgibmV0OiBhZGQgZ2VuZXJpYw0KcGVyY3B1IHBhZ2VfcG9vbCBh
bGxvY2F0b3IiKSBpcyBub3QgZWFzeSB0byBiYWNrcG9ydC4NCg0KV2l0aCB0aGVzZSBzZXR0aW5n
cyB3ZSB3ZXJlIG5vdCBhYmxlIHRvIHJ1biBvdXIgdGVzdCB3b3JrbG9hZCB0aGF0DQpyZXByb2R1
Y2VzIHRoZSB3YXJuaW5nLiBCeSB0aGF0LCBJIHNpbXBseSBjYW4ndCB0ZWxsIGlmIGl0IHJlcHJv
ZHVjZXMNCm9yIG5vdC4NCg0KQmVzdCByZWdhcmRzLA0KRmVsaXgNCg0KPiANCj4gaGVscD8NCj4g
DQo+ID4gSSB3aWxsIGhhdmUgdG8gbG9vayBpbnRvIHRoYXQgaW4gbW9yZSBkZXB0aC4NCj4gPiAN
Cj4gPiBUaGFua3MgZm9yIHlvdXIgaW5wdXQgU2ViYXN0aWFuLg0KPiANCj4gWW91IGFyZSB3ZWxj
b21lLg0KPiANCj4gU2ViYXN0aWFuDQoNCi0tIA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENl
bnRlcg0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJt
YW55DQoNCg0K
