package com.github.shinkou.crawler4j_test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import edu.uci.ics.crawler4j.crawler.CrawlConfig;
import edu.uci.ics.crawler4j.crawler.CrawlController;
import edu.uci.ics.crawler4j.fetcher.PageFetcher;
import edu.uci.ics.crawler4j.robotstxt.RobotstxtConfig;
import edu.uci.ics.crawler4j.robotstxt.RobotstxtServer;

public class Starter
{
	private static Pattern regexUrlPrefix
		= Pattern.compile("^https?://[^/]+/");

	private static String mustStartWith;

	public static String getMustStartWith()
	{
		return mustStartWith;
	}

	public static void main(String[] args) throws Exception
	{
		String startingPoint = args[0];

		Matcher m = regexUrlPrefix.matcher(startingPoint);
		if (! m.matches())
		{
			System.err.println("Invalid starting point: " + startingPoint);
			return;
		}
		mustStartWith = System.getProperty("url.prefix", m.group(0));

		String dirStorage = System.getProperty("dir.storage", "/tmp");

		int numberOfCrawlers = Integer.parseInt
		(
			System.getProperty("crawler.threads", "4")
		);

		CrawlConfig config = new CrawlConfig();
		config.setCrawlStorageFolder(dirStorage);

		PageFetcher pageFetcher = new PageFetcher(config);
		RobotstxtConfig robotstxtConfig = new RobotstxtConfig();
		RobotstxtServer robotstxtServer
			= new RobotstxtServer(robotstxtConfig, pageFetcher);
		CrawlController controller
			= new CrawlController(config, pageFetcher, robotstxtServer);

		controller.addSeed(startingPoint);

		controller.start(TestCrawler.class, numberOfCrawlers);
	}
}
